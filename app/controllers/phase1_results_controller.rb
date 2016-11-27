class Phase1ResultsController < ApplicationController
	
	def index
		Phase1Result.delete_all
		
      hash1 = Phase1.group(:choice_1).count(:id)
      hash2 = Phase1.group(:choice_2).count(:id)
      hash3 = Phase1.group(:choice_3).count(:id)
      hash4 = Phase1.group(:choice_4).count(:id)
      hash5 = Phase1.group(:choice_5).count(:id)
      
      all_choices = hash1.merge(hash2).merge(hash3).merge(hash4).merge(hash5){|key,oldval,newval| oldval + newval }
      
      least_popular = (all_choices.select { |k, v| v == all_choices.values.min }.keys).to_a
        
        counter1 = {}
      	counter2 = {}
      	counter3 = {}
      
      Phase1.all.each do |t|
      	name = t.name
      	if name == nil
                break
        end
      	nric = t.nric
      	school = t.school
      	class_name = t.class_name
      	email = t.email
      	phone = t.phone
      	
      	(1..5).each do |i|
      		a = t.public_send("choice_" + i.to_s)
      		if counter1[a] == nil
      			counter1[a] = 0
      		end
      	end
      	
      	(1..5).each do |j|
      		b = t.public_send("choice_" + j.to_s)
      		if counter2[b] == nil
      			counter2[b] = 0
      		end
      	end
      	
      	(1..5).each do |q|
      		c = t.public_send("choice_" + q.to_s)
      		if counter3[c] == nil
      			counter3[c] = 0
      		end
      	end
      	
      	if least_popular.include?t.choice_1 && counter1[t.choice_1] < 20
      		taster_1 = t.choice_1
      		counter1[t.choice_1] = counter1[t.choice_1] + 1
      		
      	elsif least_popular.include?t.choice_2 && counter1[t.choice_2] < 20
      		taster_1 = t.choice_2
      		counter1[t.choice_2] = counter1[t.choice_2] + 1
      		
      	elsif least_popular.include?t.choice_3 && counter1[t.choice_3] < 20
      		taster_1 = t.choice_3
      		counter1[t.choice_3] = counter1[t.choice_3] + 1
      		
      	elsif least_popular.include?t.choice_4 && counter1[t.choice_4] < 20
      		taster_1 = t.choice_4
      		counter1[t.choice_4] = counter1[t.choice_4] + 1
      		
      	elsif least_popular.include?t.choice_5 && counter1[t.choice_5] < 20
      		taster_1 = t.choice_5
      		counter1[t.choice_5] = counter1[t.choice_5] + 1
      		
      	elsif counter1[t.choice_1] < 20
      		taster_1 = t.choice_1
      		counter1[t.choice_1] = counter1[t.choice_1] + 1
      		
      	else taster_1 = nil
      	end
      	
      	
      	if counter2[t.choice_2] < 20 && taster_1 != t.choice_2
      		taster_2 = t.choice_2
      		counter2[t.choice_2] = counter2[t.choice_2] + 1
      		
      	elsif counter2[t.choice_3] < 20 && taster_1 != t.choice_3
      		taster_2 = t.choice_3
      		counter2[t.choice_3] = counter2[t.choice_3] + 1
      		
      	elsif counter2[t.choice_4] < 20 && taster_1 != t.choice_4
      		taster_2 = t.choice_4
      		counter2[t.choice_4] = counter2[t.choice_4] + 1
      		
      	elsif counter2[t.choice_5] < 20 && taster_1 != t.choice_5
      		taster_2 = t.choice_5
      		counter2[t.choice_5] = counter2[t.choice_5] + 1
      	
      	else taster_2 = nil
      	end
      	
      	if counter3[t.choice_3] < 20 && taster_1 != t.choice_3 && taster_2 != t.choice_3
      		taster_3 = t.choice_3
      		counter3[t.choice_3] = counter3[t.choice_3] + 1
      		
      	elsif counter3[t.choice_4] < 20 && taster_1 != t.choice_4 && taster_2 != t.choice_4
      		taster_3 = t.choice_4
      		counter3[t.choice_4] = counter3[t.choice_4] + 1
      		
      	elsif counter3[t.choice_5] < 20 && taster_1 != t.choice_5 && taster_2 != t.choice_5
      		taster_3 = t.choice_5
      		counter3[t.choice_5] = counter3[t.choice_5] + 1

      	else taster_3 = nil
      	end

      	Phase1Result.create(:name=>name, :nric=>nric, :school=>school, :class_name=>class_name, :email=>email, :phone=>phone, :taster_1=>taster_1, :taster_2=>taster_2, :taster_3=>taster_3)
      	
      end
      
        if params[:page].nil? || params[:page].empty?
        	@current_page = 1
        else
        	@current_page = params[:page].to_i
        end
        offset = (@current_page-1)*10
        @pages = Phase1Result.all.count.div 10 + 1
        @phase1_result= Phase1Result.all.order(updated_at: :desc).limit(10).offset(offset)
        respond_to do |format|
        	format.html
        	format.csv { send_data Phase1Result.all.to_csv }
        	format.xls { send_data Phase1Result.all.to_csv(col_sep: "\t") }
        end
  end
end
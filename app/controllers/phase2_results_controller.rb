class Phase2ResultsController < ApplicationController
    
    def index
      Phase2Result.delete_all
      
      hash1 = Phase2.group(:choice_1).count(:id)
      hash2 = Phase2.group(:choice_2).count(:id)
      
      all_choices = hash1.merge(hash2){|key,oldval,newval| oldval + newval }
      
      least_popular = (all_choices.select { |k, v| v == all_choices.values.min }.keys).to_a
      
      counter = {}
      
      Phase2.all.each do |t|
            name = t.name
            nric = t.nric
            school = t.school
            class_name = t.class_name
            email = t.email
            phone = t.phone
            
            (1..2).each do |i|
              a = t.public_send("choice_" + i.to_s)
              if counter[a] == nil
                counter[a] = 0
              end
            end
        
            if least_popular.include?t.choice_1 && counter[t.choice_1] < 20 
              final_selection = t.choice_1
              counter[t.choice_1] = counter[t.choice_1] + 1
              
              elsif least_popular.include?t.choice_2 && counter[t.choice_1] < 20 
              final_selection = t.choice_2
              counter[t.choice_1] = counter[t.choice_1] + 1
              
              elsif counter[t.choice_1] < 20
              final_selection = t.choice_1
              counter[t.choice_1] = counter[t.choice_1] + 1
              
              elsif counter[t.choice_2] < 20
              final_selection = t.choice_2
              counter[t.choice_2] = counter[t.choice_2] + 1
              
              else final_selection = nil
              
            end

            Phase2Result.create(:name=>name, :nric=>nric, :school=>school, :class_name=>class_name, :email=>email, :phone=>phone, :final_selection=>final_selection)
      
      end
      
        if params[:page].nil? || params[:page].empty?
        	@current_page = 1
        else
        	@current_page = params[:page].to_i
        end
        offset = (@current_page-1)*10
        @pages = Phase2Result.all.count.div 10 + 1
        @phase2_result= Phase2Result.all.order(updated_at: :desc).limit(10).offset(offset)
        respond_to do |format|
        	format.html
        	format.csv { send_data Phase2Result.all.to_csv }
        	format.xls { send_data Phase2Result.all.to_csv(col_sep: "\t") }
        end
    end
end

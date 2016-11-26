class Phase1ResultsController < ApplicationController
    
    def index
        Phase1Result.delete_all

        counter = {}
        
        Phase1.all.each do |p|
            name = p.name
              if name == nil
                break
              end
            nric = p.nric
            school = p.school
            class_name = p.class_name
            email = p.email
            phone = p.phone
            
        (1..5).each do |i|
          a = p.public_send("choice_" + i.to_s)
            if counter[a] == nil
              counter[a] = 0
            end
        end
        
        c1 = counter.select {|k,v| k == p.choice_1}
        c2 = c1.merge(counter.select {|k,v| k == p.choice_2})
        c3 = c2.merge(counter.select {|k,v| k == p.choice_3})
        c4 = c3.merge(counter.select {|k,v| k == p.choice_4})
        hash = c4.merge(counter.select {|k,v| k == p.choice_5})
        
        taster_counters = [{}, {}, {}]
        
        (1..5).each do |i|
          a = p.public_send("choice_" + i.to_s)
            (0..2).each do |j|
              if taster_counters[j][a] == nil
                taster_counters[j][a] = 0
              end
            end
        end
        
        hash1 = hash.delete_if {|k,v| v > 21}
        min = hash1.min_by{|k,v| v}
        taster_1 = min.first
        counter[taster_1] = counter[taster_1] + 1  
        taster_counters[0][taster_1] = taster_counters[0][taster_1] + 1

        hash2 = hash.delete_if {|k,v| k == taster_1}
        hash_2 = hash2.delete_if {|k,v| v > 21}
        min2 = hash_2.min_by{|k,v| v}
        taster_2 = min2.first
        counter[taster_2] = counter[taster_2] + 1
        taster_counters[1][taster_2] = taster_counters[1][taster_2] + 1

        hash_2 = hash.delete_if {|k,v| k == taster_1}
        hash3 = hash_2.delete_if {|k, v| k == taster_2}
        hash_3 = hash3.delete_if {|k,v| v > 21}
        min3 = hash_3.min_by{|k,v| v}
        taster_3 = min3.first
        counter[taster_3] = counter[taster_3] + 1
        taster_counters[2][taster_3] = taster_counters[2][taster_3] + 1
        
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
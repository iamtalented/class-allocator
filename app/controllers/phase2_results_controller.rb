class Phase2ResultsController < ApplicationController
    
    def index
      Phase2Result.delete_all

      counter = {}
      
      Phase2.all.each do |p|
        name = p.name
          if name == nil
            break
          end
        nric = p.nric
        school = p.school
        class_name = p.class_name
        email = p.email
        phone = p.phone
        
        (1..2).each do |i|
          a = p.public_send("choice_" + i.to_s)
            if counter[a] == nil
              counter[a] = 0
            end
        end

        c1 = counter.select {|k,v| k == p.choice_1}
        hash = c1.merge(counter.select {|k,v| k == p.choice_2})
        
        hash1 = hash.delete_if {|k,v| v > 21}
        min = hash1.min_by{|k,v| v}
        final_selection = min.first
        counter[final_selection] = counter[final_selection] + 1
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

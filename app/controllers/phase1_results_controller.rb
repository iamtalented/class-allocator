class Phase1ResultsController < ApplicationController
    
    def index
      Phase1Result.delete_all
      Phase1.all.each do |t|
            name = t.name
            nric = t.nric
            school = t.school
            class_name = t.class_name
            email = t.email
            phone = t.phone
            taster_1 = t.choice_1
            taster_2 = t.choice_2
            taster_3 = t.choice_3

            Phase1Result.create(:name=>name, :nric=>nric, :school=>school, :class_name=>class_name, :email=>email, :phone=>phone, :taster_1=>taster_1, :taster_2=>taster_2, :taster_3=>taster_3)
      
      end
      
        #@phase1s = Phase1.all
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

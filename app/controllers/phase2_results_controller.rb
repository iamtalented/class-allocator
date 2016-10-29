class Phase2ResultsController < ApplicationController
    
    def index
      Phase2Result.delete_all
      Phase2.all.each do |t|
            name = t.name
            nric = t.nric
            class_name = t.class_name
            email = t.email
            phone = t.phone
            final_selection = t.choice_1


            Phase2Result.create(:name=>name, :nric=>nric, :class_name=>class_name, :email=>email, :phone=>phone, :final_selection=>final_selection)
      
      end
      
        #@phase1s = Phase1.all
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

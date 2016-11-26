class Phase2sController < ApplicationController
    
    def index
      if params[:page].nil? || params[:page].empty?
        @current_page = 1
      else
        @current_page = params[:page].to_i
      end
      offset = (@current_page-1)*10
      @pages = Phase2.all.count.div 10 + 1
      @phase2s= Phase2.all.order(updated_at: :desc).limit(10).offset(offset)
    end
    
    def new
    end
  
    def import
      Phase2.import(params[:file])
      redirect_to phase2s_path, notice: "Imported!"
    end
    
    def remove_all
      Phase2.delete_all
      redirect_to phase2s_path
    end
end

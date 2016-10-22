class Phase1sController < ApplicationController
  
  def index
    if params[:page].nil? || params[:page].empty?
      @current_page = 1
    else
      @current_page = params[:page].to_i
    end
    offset = (@current_page-1)*10
    @pages = Phase1.all.count.div 10 + 1
    @phase1s= Phase1.all.order(updated_at: :desc).limit(10).offset(offset)
  end
  
  def new
  end
  
  def show
    @phase1s = Phase1.all
  end

  def import
    Phase1.import(params[:file])
    redirect_to phase1s_path, notice: "Imported!"
  end
end
class Phase2sController < ApplicationController
    def index
        @phase2s = Phase2.all
    end
    
    
    def import
        Phase2.import(params[:file])
        redirect_to phase2s_path, notice: "Imported!"
    end
end


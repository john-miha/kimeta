class ViewpointsController < ApplicationController
    def show
        #テンプレート変数の値を代入
        @viewpoint = Viewpoint.find(params[:id])
        end

        def new
        @viewpoint = Viewpoint.new
        end

        def create
        @viewpoint = Viewpoint.new(viewpoints_params)
    end

    # Strong Parameter
    def viewpoints_params
        viewpoints.require(:viewpoint).permit(:name)
    end    
end

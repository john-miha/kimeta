class ChartsController < ApplicationController
    def index
        #テンプレート変数の値を代入
        @charts = Chart.all
      end
    
      def show
        #テンプレート変数の値を代入
        set_chart
        @pagy, @evaluations = pagy(@chart.evaluations.order(id: :desc))
      end
    
      def new
        @chart = Chart.new
      end
    
      def create
        @chart = Chart.new(charts_params)
    
        if @chart.save
          flash[:success] = '正常に投稿されました'
          redirect_to  @chart
        else
          flash.now[:danger] = '投稿されませんでした'
          render :new
        end
      end
    
      def edit
        set_chart
      end
    
      def update
        set_chart
    
        if @chart.update(charts_params)
          flash[:success] = '正常に投稿されました'
          redirect_to  @chart
        else
          flash.now[:danger] = '投稿されませんでした'
          render :edit
        end
      end
    
      def destroy
        set_chart
        @chart_header.destroy
    
        flash[:success] = 'Message は正常に削除されました'
        redirect_to charts_url
      end
    
      def confirm
      end
    
      def set_chart
        @chart = Chart.find(params[:id])
      end
    
      # Strong Parameter
      def charts_params
        params.require(:chart).permit(:title, :description)
      end
       
end

class ChartsController < ApplicationController
    def index
        #テンプレート変数の値を代入
        #@charts = Chart.all
        #pagyの設定（要確認）
        @pagy, @charts = pagy(Chart.all)
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
        binding.pry

        if @chart.save
          flash[:success] = '正常に投稿されました'
          redirect_to  @chart
        else
          flash.now[:danger] = '投稿されませんでした'
          render :new
        end

        #配列でやってくるparamsを一時変数に格納
        evaluationscore = params[:evaluationscores]
        evaluationcomment = params[:evaluationcomments]
        itemname = params[:itemnames]
        viewpointname = params[:viewpointnames]

        #ここから下をfor文で回す
        for id in 0..8 do
          @evaluation = Evaluation.new
          @evaluation.score = evaluationscore[id]
          @evaluation.comment = evaluationcomment[id]
          @evaluation.chart_id = @chart.id
          @evaluation.save

          @item = Item.new
          @item.evaluation_id = @evaluation.id
          @item.name = itemname[id]
          @item.save

          @viewpoint = Viewpoint.new
          @viewpoint.evaluation_id = @evaluation.id
          @viewpoint.name = viewpointname[id]
          @viewpoint.save 
        end
        #ここまでをfor文で回す

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
        @chart.destroy
    
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

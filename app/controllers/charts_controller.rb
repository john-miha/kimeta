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
    #binding.pry

    if @chart.save
      flash[:success] = '正常に投稿されました'
    else
      flash.now[:danger] = '投稿されませんでした'
      render :new
    end

    #トランザクション処理を実装する
    @chart.transaction do
      #binding.pry
      #配列でやってくるparamsを一時変数に格納
      evaluationscore = params[:evaluationscores]
      evaluationcomment = params[:evaluationcomments]
      itemname = params[:itemnames]
      viewpointname = params[:viewpointnames]

      #ここから下をfor文で回す
      #eval[0][3][6]のitemは共通なので、カウンタか剰余でそこを表現してあげないといけない
      #eval[0][1][2]のViewpointは共通
      #↑は嘘。多対多に作り直す必要があるかも。evalは複数のitemを持つし、itemも複数のevalをもつ。中間テーブルを作る。

      #一旦今のままのテーブルで行く。id=0のとき, item=0 1のとき1, 2のとき2
      #                          3のとき0,4のとき1, 5のとき2
      #                          なので、itemについては3の剰余でいける。
      #viewpointについては、条件分岐を書く必要がある。

      for id in 0..8 do
        @evaluation = Evaluation.new
        @evaluation.score = evaluationscore[id]
        @evaluation.comment = evaluationcomment[id]
        @evaluation.chart_id = @chart.id
        @evaluation.save!

        @item = Item.new
        @item.evaluation_id = @evaluation.id
        @item.name = itemname[id%3]
        @item.save!

        @viewpoint = Viewpoint.new
        @viewpoint.evaluation_id = @evaluation.id
        if id <3 then
          @viewpoint.name = viewpointname[0]
        elsif id <6 then 
          @viewpoint.name = viewpointname[1]
        else
          @viewpoint.name = viewpointname[2]
        end
        @viewpoint.save!
      end#for
      #ここまでをfor文で回す
    end #transaction

    #transaction成功時の処理
    #redirectは最後にしたほうがよい
    redirect_to  @chart

    # トランザクション失敗時の処理
    rescue => e
      flash.now[:danger] = '投稿されませんでした'
      render :new
    #rescueにはendが不要
      #正常に投稿されたらredirect。ここは本当はトランザクションで囲んだほうがいい。
      #redirectは最後にしたほうがよい
  end
    
  def edit
    set_chart
  end
    
  def update
    set_chart

    if @chart.update(charts_params)
      flash[:success] = '正常に投稿されました'
      #レンダリングは全てを保存したあとに。
      #redirect_to  @chart
    else
      flash.now[:danger] = '投稿されませんでした'
      render :edit
    end

    #トランザクション処理を実装する
    @chart.transaction do

      #binding.pry
      #配列でやってくるparamsを一時変数に格納
      evaluationscore = params[:evaluationscores]
      evaluationcomment = params[:evaluationcomments]
      itemname = params[:itemnames]
      viewpointname = params[:viewpointnames]

      #ここから下をfor文で回す
      #eval[0][3][6]のitemは共通なので、カウンタか剰余でそこを表現してあげないといけない
      #eval[0][1][2]のViewpointは共通
      #↑は嘘。多対多に作り直す必要があるかも。evalは複数のitemを持つし、itemも複数のevalをもつ。中間テーブルを作る。

      #一旦今のままのテーブルで行く。id=0のとき, item=0 1のとき1, 2のとき2
      #                          3のとき0,4のとき1, 5のとき2
      #                          なので、itemについては3の剰余でいける。
      #viewpointについては、条件分岐を書く必要がある。

      for id in 0..8 do

        @chart.evaluations[id].score = evaluationscore[id]
        @chart.evaluations[id].comment = evaluationcomment[id]
        #transaction処理をするときはsaveやcreateに!をつけて、失敗したら例外を吐くようにする
        @chart.evaluations[id].save!

        @chart.evaluations[id].items.first.name = itemname[id%3]
        @chart.evaluations[id].items.first.save!

        if id <3 then
          @chart.evaluations[id].viewpoints.first.name = viewpointname[0]
        elsif id <6 then 
          @chart.evaluations[id].viewpoints.first.name = viewpointname[1]
        else
          @chart.evaluations[id].viewpoints.first.name = viewpointname[2]
        end
        @chart.evaluations[id].viewpoints.first.save!
      end
      #ここまでをfor文で回す


    end #transaction
    #transaction成功時の処理
    #redirectは最後にしたほうがよい
    redirect_to  @chart

    # トランザクション失敗時の処理
    rescue => e
      flash.now[:danger] = '投稿されませんでした'
      render :edit
    #rescueにはendが不要
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

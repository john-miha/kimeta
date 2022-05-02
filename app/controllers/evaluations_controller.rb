class EvaluationsController < ApplicationController
    def show
        #テンプレート変数の値を代入
        @evaluation = Evaluation.find(params[:id])
        end

        def new
        @evaluation = Evaluation.new
        end

        def create

        @evaluation = Evaluation.new(evaluations_params)
        @evaluation.save
        @item = Item.new
        @item.evaluation_id = @evaluation.id
        @item.name = params[:itemname]
        @item.save
        @viewpoint = Viewpoint.new
        @viewpoint.evaluation_id = @evaluation.id
        @viewpoint.name = params[:viewpointname]
        @viewpoint.save

        binding.pry

    end

    # Strong Parameter
    def evaluations_params
        params.require(:evaluation).permit(:score, :comment)
    end
end

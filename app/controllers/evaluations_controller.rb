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
    end

    # Strong Parameter
    def evaluations_params
    params.require(:evaluation).permit(:score, :comment)
    end
end

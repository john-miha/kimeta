class ItemsController < ApplicationController

    def show
        #テンプレート変数の値を代入
        @item = Item.find(params[:id])
        end

        def new
        @item = Item.new
        end

        def create
        @item = Item.new(items_params)
    end

    # Strong Parameter
    def items_params
    params.require(:item).permit(:name)
    end
    
end

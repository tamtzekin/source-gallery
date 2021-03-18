class ItemsController < ApplicationController

    # Check login first
    before_action :force_login

    def index
        # If there's a search, filter
        if params[:q].present?
            # run search
            @items = Item.where("lower(title) LIKE ?", "%" + params[:q].downcase + "%")
        else
            @items = Item.all
        end
    end 

    def show
        @item = Item.find(params[:id])
    end 
end

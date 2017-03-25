class UController < ApplicationController

  before_action :set_user, only: [:index, :show]

  private

    def set_user
      #@user = User.includes(:articles).where(screen_name: params[:id]).first
      @user = User.includes(:articles).where(name: params[:name]).first
    end
end

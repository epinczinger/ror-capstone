class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @opinion = Opinion.new
  end

  def index; end
end

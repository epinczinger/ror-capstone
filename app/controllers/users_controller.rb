class UsersController < ApplicationController
  def show
    @user = User.with_photos.find(params[:id])
    @opinion = Opinion.new
  end

  def index; end
end

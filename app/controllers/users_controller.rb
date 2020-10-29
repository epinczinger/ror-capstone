class UsersController < ApplicationController
  def show
    @user = User.includes(:photo_attachment, :cover_image_attachment).find(params[:id])
    @opinion = Opinion.new
  end

  def index; end
end

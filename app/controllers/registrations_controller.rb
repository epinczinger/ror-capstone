class RegistrationsController < Devise::RegistrationsController
  def edit
    user = current_user
  end
 
  private

  

  def sign_up_params
    params.require(:user).permit(:fullname, :username, :email, :password, :password_confirmation)
  end

  def sign_in_params
    params.require(:user).permit(:username, :password)
  end

  def account_update_params
    params.require(:user).permit(:fullname, :username, :email, :password, :password_confirmation, :current_password, :photo, :cover_image)
  end
end

class RegistrationsController < Devise::RegistrationsController

    private

    def sign_up_params
        params.require(:user).permit(:fullname, :username, :email, :password, :password_confirmation)
    end

    def sign_in_params
        params.require(:user).permit(:username, :password)
    end

    def account_update_params
        params.require(:user).permit(:fullname, :username, :email, :password, :password_confirmation, :current_password)
    end
end
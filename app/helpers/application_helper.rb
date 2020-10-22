# fr
module ApplicationHelper
  def sign_in_out
    if user_signed_in?
      out = ''
      out << link_to(current_user.fullname, edit_user_registration_path, class: 'button is-info')
      out << link_to('Log Out', destroy_user_session_path, method: :delete, class: 'is-danger button')
      out.html_safe
    else
      out = ''
      out << link_to('Log In', new_user_session_path, class: 'button is-info')
      out << link_to('Sign In', new_user_registration_path, class: 'is-primary button')
      out.html_safe
    end
  end
end

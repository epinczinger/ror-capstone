# fr
module ApplicationHelper
  def sign_in_out
    out = ''
    if user_signed_in?
      out << link_to(current_user.fullname, edit_user_registration_path, class: 'button is-info')
      out << link_to('Log Out', destroy_user_session_path, method: :delete, class: 'is-danger button')
    else
      out << link_to('Log In', new_user_session_path, class: 'button is-info')
      out << link_to('Sign In', new_user_registration_path, class: 'is-primary button')
    end
    out.html_safe
  end

  def like_or_dislike_btn(opinion)
    if current_user != opinion.user && current_user != nil
    like = Like.find_by(opinion: opinion, user: current_user)
    if like
      link_to('Dislike!', like_path(id: like.id, opinion_id: opinion.id), method: :delete, class: 'is-small is-danger button')
    else
      link_to('Like!', opinion_likes_path(opinion_id: opinion.id), method: :post, class: 'button is-info is-small')
    end
  end
  end
end

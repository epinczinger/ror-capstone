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
    return unless current_user != opinion.user && !current_user.nil?

    like = Like.find_by(opinion: opinion, user: current_user)
    if like
      link_to('Dislike!', like_path(id: like.id, opinion_id: opinion.id),
              method: :delete, class: 'is-small is-danger button')
    else
      link_to('Like!', opinion_likes_path(opinion_id: opinion.id), method: :post, class: 'button is-info is-small')
    end
  end

  def show_cover_image(user)
    return if user.nil?

    if user.cover_image.attached?
      image_tag(user.cover_image, alt: user.username, class: '')
    else
      image_tag('https://source.unsplash.com/900x300/?surf', alt: user.username, class: 'pr-2')
    end
  end

  def show_photo(user)
    return if user.nil?

    if user.photo.present?
      image_tag(user.photo, alt: user.username, class: '')
    else
      gravatar_image_tag(user.email, size: 64, alt: 'profile pic')
    end
  end

  def edit_destroy_btn(opinion)
    return unless user_signed_in? && opinion.user == current_user

    out = ''
    out << link_to('Edit', edit_opinion_path(opinion), class: 'button is-light is-small')
    out << ' '
    out << link_to('Destroy', opinion, method: :delete, data: { confirm: 'Are you sure?' },
                                       class: 'button is-danger is-small')
    out.html_safe
  end

  def authorized_partial(the_partial)
    render partial: the_partial if user_signed_in?
  end

  def render_flash_messages
    render partial: 'layouts/flash_notice', object: flash[:notice] if flash[:notice]

    render partial: 'layouts/flash_alert', object: flash[:alert] if flash[:alert]
  end

  def display_follow_btn(user, the_partial)
    return unless current_user.id != user.id
    return if current_user.following?(user)

    render partial: the_partial, locals: { obj: user }
  end

  def display_unfollow_btn(user, the_partial)
    return unless current_user.id != user.id
    return unless current_user.following?(user)

    render partial: the_partial, locals: { obj: user }
  end
end

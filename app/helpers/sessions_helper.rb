module SessionsHelper
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies[:user_id]
      user = User.find_by(id: cookies[:user_id])
      if user
        remember_token = cookies[:remember_token]
        remember_digest = user.remember_digest
        user_authenticated = BCrypt::Password.new(remember_digest).is_password?(remember_token)

        if user_authenticated
          log_in user
          @current_user = user
        end
      end

    end
  end
  def log_in(user)
    session[:user_id] = user.id
  end
  def logged_in?
    !current_user.nil?
  end
  def log_out
    session.delete(:user_id)
    forget(@current_user)
    @current_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
  
  def remember(user)
    remember_token = SecureRandom.urlsafe_base64
    user.remember(remember_token)

    cookies.permanent[:user_id] = user.id
    cookies.permanent[:remember_token] = remember_token
  end

  def forget(user)
    user.update(remember_digest: nil) unless user.nil?
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end

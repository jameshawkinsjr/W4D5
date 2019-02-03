class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    def login!(user)
        session[:session_token] = user.session_token
    end

    def logged_in?
        # return false if session[:session_token] == nil
        # session_token = session[:session_token]
        # return true if User.find_user_by_session_token(session_token)
        !!current_user
    end

    def current_user
        @current_user ||= User.find_by_session_token(session[:session_token])
    end

    def logout!
        current_user.reset_session_token!
        session[:session_token] = nil
    end

end

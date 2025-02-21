class SessionsController < ApplicationController
    def new
    end
  
    def create
      user = User.find_by(email: params[:email])
      Rails.logger.info "Attempting login for #{params[:email]}"
      if user && user.authenticate(params[:password])
        Rails.logger.info "Login successful for #{user.email}"
        session[:user_id] = user.id
        redirect_to feed_kudos_path, notice: "Logged in successfully!"
      else
        flash.now[:alert] = "Invalid email or password."
        render :new
      end
    end
  
    def destroy
      session.delete(:user_id)
      redirect_to login_path, notice: "Logged out!"
    end
  end
  
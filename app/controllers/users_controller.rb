class UsersController < ApplicationController
    before_action :authenticate_user!
  
    # GET /users
    # This action handles search. If a query is provided, it returns users in the same or lower hierarchy.
    def index
      if params[:query].present?
        # Search among users with role >= current user's role.
        @users = User.where("role >= ?", current_user.role)
                     .where("name LIKE ? OR email LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
      else
        @users = []
      end
    end
  
    # GET /users/:id
    # Profile page: shows basic information and 10 recent kudos sent/received.
    def show
      @user = User.find(params[:id])
      @recent_kudos_sent = @user.kudos_sent.order(created_at: :desc).limit(10)
      @recent_kudos_received = @user.kudos_received.order(created_at: :desc).limit(10)
    end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id  # Log in after sign-up.
        redirect_to feed_kudos_path, notice: "Account created successfully!"
      else
        render :new
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :role, :password, :password_confirmation)
    end
  end
  
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = current_user
  end

  def create
    @user = User.new user_params
    @user.number_of_lines, @user.number_of_projects = @user.get_the_bytes(user_params[:github])
    if @user.save
      redirect_to users_jobs_path, notice: "Created user"
    else
      flash[:error] = "Invalid email/password combination."
      render action: 'new'
    end
  end
  private
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :first_name,
                    :last_name, :email, :phone_number, :github, :linkedin)
    end
end

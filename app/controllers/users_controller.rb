class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    #debugger #La pagina no carga y es para ver en el servidor de rails los datos
  end

  def new
    @user = User.new
  end

  def create
    #@user = User.new(params[:user])    # Not the final implementation!
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      # Handle a successful save.
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end

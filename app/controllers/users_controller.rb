class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    #debugger #La pagina no carga y es para ver en el servidor de rails los datos
  end

  def new
    @user = User.new
  end

  def index
    #@users = User.all #Listar todos los usuarios
    @users = User.paginate(page: params[:page], per_page: 30) #Se usa este para poder paginar con will_paginate
  end


  def create
    #@user = User.new(params[:user])    # Not the final implementation!
    @user = User.new(user_params)
    if @user.save
      #Codigo viejo, antes de implementar la activación por email.
      #log_in @user
      #flash[:success] = "Welcome to the Sample App!"
      #redirect_to @user
      #UserMailer.account_activation(@user).deliver_now
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params #Parametros permitidos por el usuario
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    # Confirms a logged-in user.

    #def logged_in_user #Se elimino porque ahora esta en ApplicationController
    #  unless logged_in?
    #    store_location
    #    flash[:danger] = "Please log in."
    #    redirect_to login_url
    #  end
    #end

    # Confirms the correct user.

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end

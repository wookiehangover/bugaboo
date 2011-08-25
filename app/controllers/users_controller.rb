class UsersController < ApplicationController

  before_filter :find_user, :only => [:edit, :update, :destroy]
  before_filter :fetch_projects, :only => [:edit, :update, :new, :create]

  def index
    authorize! :read, User
    @users = User.all
  end

  def edit
    authorize! :edit, @user
  end

  def update
    authorize! :update, @user

    if @user.update_attributes(params[:user])
      redirect_to users_url, :notice => "#{@user.full_name} user was saved!"
    else
      render 'edit'
    end
  end

  def new
    @user = User.new
    authorize! :new, @user
  end

  def create
    @user = User.new

    authorize! :create, @user

    @user.attributes = params[:user]

    if @user.save
      redirect_to users_url, :notice => "#{@user.full_name} user was created!"
    else
      render 'new'
    end
  end

  def destroy
    authorize! :destroy, @user

    @user.destroy
    redirect_to users_url, :notice => "Successfully deleted"
  end
  private

  def find_user
    @user = User.find(params[:id])
  end

  def fetch_projects
    @projects = Project.all
  end

end


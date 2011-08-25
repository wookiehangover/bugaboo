class BugsController < ApplicationController

  helper_method :sort_column, :sort_direction

  before_filter :find_bug, :only => [:edit, :update, :destroy]
  before_filter :fetch_projects, :only => [:edit, :update, :new, :create]
  before_filter :fetch_users, :only => [:edit, :update, :new, :create]

  def index
    authorize! :read, Bug

    page            = params[:page]            ||= 1
    per_page        = params[:per_page]        ||= 10

    @bugs = Bug.order("#{sort_column} #{sort_direction}")
        .paginate(:page => page, :per_page => per_page)
        .all
  end

  def edit
    authorize! :edit, @bug
  end

  def update
    authorize! :update, @bug
    if @bug.update_attributes(params[:bug])
      redirect_to bugs_url, :notice => "Bug saved"
    else
      render 'edit'
    end
  end

  def new
    @bug = Bug.new
    authorize! :new, @bug
  end

  def create
    @bug = Bug.new
    authorize! :create, @bug
    @bug.attributes = params[:bug]
    @bug.author_id = current_user.id

    if @bug.save
      redirect_to bugs_url, :notice => "Bug was created!"
    else
      render 'new'
    end
  end

  def destroy
    authorize! :destroy, @bug
    @bug.destroy
    redirect_to bugs_url, :notice => "Successfully deleted"
  end

  private

  def find_bug
    @bug = Bug.find(params[:id])
  end

  def fetch_projects
    @projects = current_user.projects.collect {|p| [p.name, p.id] } if current_user
  end

  def fetch_users
    @users = User.all.collect {|u| [ u.full_name, u.id ] }
  end

  def sort_column
    Bug.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end

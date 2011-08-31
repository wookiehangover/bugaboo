class ProjectsController < ApplicationController

  before_filter :find_project, :only => [:edit, :update, :destroy]

  def index
    authorize! :read, Project
    @projects = Project.all

    respond_to do |format|
      format.html
      format.json  { render :json => @projects }
    end
  end

  def show
    authorize! :read, Project
    @project = Project.find(params[:id])

    render :json => @project
  end

  def edit
    authorize! :edit, @project
  end

  def update
    authorize! :update, @project
    if @project.update_attributes(params[:project])
      redirect_to projects_url, :notice => "#{@project.name} was saved!"
    else
      render 'edit'
    end
  end

  def new
    @project = Project.new
    authorize! :new, @project
  end

  def create
    @project = Project.new
    authorize! :create, @project
    @project.attributes = params[:project]

    if @project.save
      redirect_to projects_url, :notice => "#{@project.name} was created!"
    else
      render 'new'
    end
  end

  def destroy
    authorize! :destroy, @project
    @project.destroy
    redirect_to projects_url, :notice => "Successfully deleted"
  end
  private

  def find_project
    @project = Project.find(params[:id])
  end
end

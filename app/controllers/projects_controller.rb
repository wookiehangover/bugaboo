class ProjectsController < ApplicationController

  authorize_resource

  before_filter :find_project, :only => [:edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def edit
  end

  def update
     if @project.update_attributes(params[:project])
      redirect_to projects_url, :notice => "#{@project.name} was saved!"
    else
      render 'edit'
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new
    @project.attributes = params[:project]

    if @project.save
      redirect_to projects_url, :notice => "#{@project.name} was created!"
    else
      render 'new'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, :notice => "Successfully deleted"
  end
  private

  def find_project
    @project = Project.find(params[:id])
  end
end

class TasksController < ApplicationController
  def index
  end

  def new
    @task = Task.new
  end

  def create
    Task.create(params[:task])
    redirect_to new_task_path
  end
end

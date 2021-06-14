class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort_expired].present?
      @tasks = Task.all.by_limit
    elsif params[:title].present? || params[:status].present?
      if params[:title].present? && params[:status].present?
        @tasks = Task.title_like(params[:title]).status_like(params[:status])
      elsif params[:title].present? && params[:status].blank?
        @tasks = Task.title_like(params[:title])
      elsif params[:title].blank? && params[:status].present?
        @tasks = Task.status_like(params[:status])
      end
    else
      @tasks = Task.all.by_created_at
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task.id), notice: "タスクを作成しました！"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました！"
  end

  private

  def task_params
    params.require(:task).permit(:title, :details, :limit).merge(status: params[:task][:status].to_i)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end

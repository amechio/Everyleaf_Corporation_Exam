class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort_limit].present?
      @tasks = Task.all.by_limit.page(params[:page]).per(5)
    elsif params[:sort_priority].present?
      @tasks = Task.all.by_priority.page(params[:page]).per(5)
    elsif params[:title].present? || params[:status].present? || params[:priority].present?
      if params[:title].present? && params[:status].present?
        if params[:priority].present?
          @tasks = Task.title_like(params[:title]).select_status(params[:status]).select_priority(params[:priority]).page(params[:page]).per(5)
        elsif params[:priority].blank?
          @tasks = Task.title_like(params[:title]).select_status(params[:status]).page(params[:page]).per(5)
        end
      elsif params[:title].present? && params[:status].blank?
        if params[:priority].present?
          @tasks = Task.title_like(params[:title]).select_priority(params[:priority]).page(params[:page]).per(5)
        elsif params[:priority].blank?
          @tasks = Task.select_status(params[:title]).page(params[:page]).per(5)
        end
      elsif params[:title].blank? && params[:status].present?
        if params[:priority].present?
          @tasks = Task.select_status(params[:status]).select_priority(params[:priority]).page(params[:page]).per(5)
        elsif params[:priority].blank?
          @tasks = Task.select_status(params[:status]).page(params[:page]).per(5)
        end
      end
    else
      @tasks = Task.all.by_created_at.page(params[:page]).per(5)
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
    params.require(:task).permit(:title, :details, :limit).merge(status: params[:task][:status].to_i).merge(priority: params[:task][:priority].to_i)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end

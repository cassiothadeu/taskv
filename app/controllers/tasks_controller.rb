class TasksController < ApplicationController
  before_action :require_logged_user
  before_action :find_task, except: %w[index create batch_update]

  def index
    @task = Task.new
    @tasks = current_user.tasks.order_by_pending
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: t('flash.tasks.create.notice')
    else
      redirect_to tasks_path, alert: t('inline_errors', errors: @task.errors.full_messages.to_sentence)
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('flash.tasks.update.notice')
    else
      render :edit
    end
  end

  def batch_update
    TaskList.update_completed_at(current_user, params[:task_ids])

    redirect_to tasks_path,
      notice: t('flash.tasks.batch_update.notice')
  end

  def remove
  end

  def destroy
    @task.destroy!
    redirect_to tasks_path, notice: t('flash.tasks.destroy.notice')
  end

  private

  def task_params
    params
      .require(:task)
      .permit(:title)
  end

  def find_task
    @task = current_user.tasks.find(params[:id])
  end
end

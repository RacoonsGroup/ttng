class TimeEntriesController < ApplicationController
  inject :time_entry_manager

  before_filter :find_task

  def create
    authorize! :create, TimeEntry
    time_entry_manager.create(@task, create_task_params) do |time_entry, saved|
      if saved
        render json: time_entry
      else
        render json: time_entry.errors.messages, status: 422
      end
    end
  end

  protected

  def find_task
    @task = current_user.tasks.find(params[:task_id])
  end

  def create_task_params
    TimeEntryPermitter.permit(params)
  end
end

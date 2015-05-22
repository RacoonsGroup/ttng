class TimeEntriesController < ApplicationController
  inject :time_entry_manager

  before_filter :find_task

  def create
    authorize! :create, TimeEntry
    time_entry_manager.create(@related_task, create_task_params) do |time_entry, saved|
      if saved
        render json: time_entry
      else
        render json: time_entry.errors.messages, status: 422
      end
    end
  end

  protected

  def find_task
    @related_task = current_user.related_tasks.find(params[:related_task_id])
  end

  def create_task_params
    TimeEntryPermitter.permit(params)
  end
end

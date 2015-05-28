class TimeEntriesController < ApplicationController
  inject :time_entry_manager

  before_filter :find_task
  before_filter :find_time_entry, only: :destroy

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

  def destroy
    time_entry_manager.destroy(@time_entry)
    redirect_to :back
  end

  protected

  def find_task
    @related_task = if current_user.chief?
                    RelatedTask.find(params[:related_task_id])
                  else
                    current_user.related_tasks.find(params[:related_task_id])
                  end
  end

  def create_task_params
    TimeEntryPermitter.permit(params)
  end

  def find_time_entry
    @time_entry = if current_user.chief?
                    TimeEntry.find(params[:id])
                  else
                    current_user.time_entries.find(params[:id])
                  end
  end
end

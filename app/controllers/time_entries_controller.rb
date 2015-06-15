class TimeEntriesController < ApplicationController
  inject :time_entry_manager

  respond_to :html, :json

  before_filter :find_task
  before_filter :find_time_entry, only: [:update, :destroy]

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

  def update
    @time_entry.update_attributes(create_task_params)
    respond_with @time_entry
  end

  def destroy
    time_entry_manager.destroy(@time_entry)
    redirect_to :back
  end

  protected

  def find_task
    @related_task = RelatedTask.find(params[:related_task_id]) 
  end

  def create_task_params
    TimeEntryPermitter.permit(params)
  end

  def find_time_entry
    @time_entry = TimeEntry.find(params[:id])
  end
end

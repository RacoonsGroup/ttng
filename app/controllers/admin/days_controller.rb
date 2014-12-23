class Admin::DaysController < Admin::AdminController
  load_and_authorize_resource

  inject :day_manager

  def index
    @days = @days.where('date >= ? and date <= ?', Date.today.beginning_of_year, Date.today.end_of_year).order(:date)
  end

  def new

  end

  def create
    day_manager.create(day_params) do |day, saved|
      if saved
        redirect_to admin_days_path
      else
        @day = day
        render :new
      end
    end
  end

  def edit

  end

  def update
    day_manager.update(@day, day_params) do |day, saved|
      if saved
        redirect_to admin_days_path
      else
        @day = day
        render :edit
      end
    end
  end

  def destroy
    day_manager.destroy(@day)
    redirect_to admin_days_path
  end

  private

  def day_params
    DayPermitter.permit(params)
  end
end
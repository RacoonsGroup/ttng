module Admin::DayHelper
  def holiday(flag)
    if flag
      t('day.labels.holiday')
    else
      t('day.labels.business_day')
    end
  end
end
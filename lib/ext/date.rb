class Iteration
  WORK_HOURS = 8

  def initialize(date)
    @date = date
  end

  def beginning
    first? ? @date.beginning_of_month : Date.new(@date.year, @date.month, 16)
  end

  def end
    first? ? Date.new(@date.year, @date.month, 15) : @date.end_of_month
  end

  def number
    @date.day < 16 ? 1 : 2
  end

  def first?
    number == 1
  end

  def second?
    number == 2
  end

  def days
    @days ||= Day.where('date >= ? AND date <= ?', beginning, self.end)
  end

  def dates
    @dates ||= (beginning..(self.end)).to_a.each do |date|
      date.instance_variable_set('@iteration', self)
    end
  end

  def business_hours
    dates.select(&:business_day?).count * WORK_HOURS
  end

  def total_hours
    dates.reject(&:weekend?).count * WORK_HOURS
  end

  def elapsed_hours
    dates.count { |d| d <= Date.today && d.business_day? } * WORK_HOURS
  end
end

class Date
  def iteration
    @iteration ||= Iteration.new(self)
  end

  def weekend?
    @weekend ||= saturday? || sunday?
  end

  def holiday?
    @holiday ||= weekend? || business_day.holiday?
  end

  def business_day?
    !holiday?
  end

  def business_day
    @business_day ||= iteration.days.detect{ |d| d.date == self } || Day.new(holiday: false)
  end
end

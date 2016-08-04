module DayoffsHelper
  def allowed_vacation(person)
    return 0 unless person.start_date
    (((Date.today - person.start_date).to_i.abs) / 365.25).ceil * ENV['VACATION_PER_YEAR'].to_i
  end

  def used_vacation(person)
    person.dayoffs.where(type: 'Vacation').sum(:days)
  end

  def sick_leaves(person)
    person.dayoffs.where(type: 'Sick Leave').sum(:days)
  end

  def unpaid_days_off(person)
    person.dayoffs.where(type: 'Unpaid Day Off').sum(:days)
  end

  def paid_days_off(person)
    person.dayoffs.where(type: 'Paid Day Off').sum(:days)
  end

  def months_worked(person)
    return 0 unless person.start_date
    (Date.today.year * 12 + Date.today.month) - (person.start_date.year * 12 + person.start_date.month)
  end

  def remaining_vacation(person)
    (allowed_vacation(person) - used_vacation(person)).ceil
  end
end
module ApplicationHelper
  def custom_format(date)
  return nil if date.blank?
  # Jan 1, 2016
  begin
    if date.class.to_s == 'String'
      date = date.to_date
    end
    if date.strftime("%b %d, %Y") == Date.today.strftime("%b %d, %Y")
      'Today'
    elsif date.strftime("%b %d, %Y") == Date.yesterday.strftime("%b %d, %Y")
      'Yesterday'
    else
      date.strftime("%b %d, %Y")
    end
  rescue => ex
    "-"
  end
end
end

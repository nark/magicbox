module ApplicationHelper
	def fdate(date)
    return "" if !date
    date.strftime("%d/%m/%Y")
  end



  def fdatetime(datetime)
    return "" if !datetime
    datetime.in_time_zone("Europe/Paris").strftime("%d/%m/%Y à %H:%M")
  end


  def ftime(time)
    return "" if !time
    time.strftime("%R %P")
  end
end

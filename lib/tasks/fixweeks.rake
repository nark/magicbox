namespace :fixweeks do
  task :date => :environment do
  	Grow.all.each do |g|
  		sdate = g.start_date
      edate = sdate + 7.days

  		g.weeks.each do |w|
  			w.start_date = sdate
  			w.end_date = edate
  			w.save

				sdate = sdate + 7.days
        edate = sdate + 7.days
  		end
  	end
  end
end
		
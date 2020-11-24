namespace :scenario do
	desc "Run scenarios"
  task :run => :environment do
  	Scenario.run
  end

  desc "Run scenarios (v2)"
  task :run2 => :environment do
  	Scenario.run2
  end
end

namespace :scenario do
	desc "Run scenarios"
  task :run => :environment do
  	Scenario.run
  end
end

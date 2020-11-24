namespace :alerts do
	desc "Get sensors value"
  task :trigger => :environment do
    Alert.all.each do |alert|
      alert.trigger
    end
  end
end

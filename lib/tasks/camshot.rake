namespace :camshot do
	desc "Get sensors value"
  task :take => :environment do
  	Room.all.each do |r|
			r.take_camshot
    end
  end
end

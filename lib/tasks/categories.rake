namespace :categories do
	desc "Seed categories"
  task :seed => :environment do
    Category.create(name: "Water", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit")
    Category.create(name: "Nutrients", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit")
    Category.create(name: "Air", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit")
    Category.create(name: "Light", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit")
  end
end

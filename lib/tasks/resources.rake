namespace :resources do
	desc "Seed resources"
  task :seed => :environment do
    # WATER
    water_category = Category.where(name: "Water").first

    Resource.create(
      name: "Water quantity",
      shortname: "H2O",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
      category_id: water_category.id,
      choices: [],
      units: ["l", "dl", "cl", "ml"]
    )

    Resource.create(
      name: "Water type",
      shortname: "Type",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
      category_id: water_category.id,
      choices: ["Tap water", "Mineral water", "Purified water", "Distiled water (reverse osmosis)"],
      units: []
    )

    Resource.create(
      name: "PH",
      shortname: "PH",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
      category_id: water_category.id,
      choices: [],
      units: ["PH"]
    )

    Resource.create(
      name: "EC",
      shortname: "EC",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
      category_id: water_category.id,
      choices: [],
      units: ["EC"]
    )


    # NUTRIENTS
    nutrients_category = Category.where(name: "Nutrients").first

    Resource.create(
      name: "Nitrogen",
      shortname: "N",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
      category_id: nutrients_category.id,
      choices: [],
      units: ["l", "dl", "cl", "ml"]
    )

    Resource.create(
      name: "Phosphorus",
      shortname: "P",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
      category_id: nutrients_category.id,
      choices: [],
      units: ["l", "dl", "cl", "ml"]
    )

    Resource.create(
      name: "Potatium",
      shortname: "K",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
      category_id: nutrients_category.id,
      choices: [],
      units: ["l", "dl", "cl", "ml"]
    )

  end
end

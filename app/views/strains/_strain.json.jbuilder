json.extract! strain, :id, :name, :description, :strain_type, :crosses, :breeder, :effects, :ailments, :flavors, :location, :terpenes, :created_at, :updated_at
json.url strain_url(strain, format: :json)

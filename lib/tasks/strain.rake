namespace :strain do
	desc "Get sensors value"
  task :seed => :environment do
  	require 'csv'
		 
		# parse strains
		strains_csv = Rails.root.join('db', 'samples', 'strains-kushy_api.2017-11-14.csv')
		CSV.parse(File.new(strains_csv), col_sep: ",", headers: false) do |row|
		  Strain.create!(
		    name: (row[3] and row[3] != "NULL") ? row[3] : nil,
		    description: (row[6] and row[6] != "NULL") ? row[6] : nil, 
		    strain_type: (row[7] and row[7] != "type") ? row[7].downcase.to_sym : nil, 
		    crosses:  (row[8] and row[8] != "NULL") ? row[8] : nil, 
		    breeder:  (row[9] and row[9] != "NULL") ? row[9] : nil, 
		    effects:  (row[10] and row[10] != "NULL") ? row[10].split(",").map { |e| e.downcase.strip } : nil, 
		    ailments: (row[11] and row[11] != "NULL") ? row[11].split(",").map { |e| e.downcase.strip } : nil, 
		    flavors:  (row[12] and row[12] != "NULL") ? row[12].split(",").map { |e| e.downcase.strip } : nil, 
		    location: (row[13] and row[13] != "NULL") ? row[13] : nil,
		    terpenes: (row[14] and row[14] != "NULL") ? row[14] : nil)
		end

		Strain.first.destroy
  end
end
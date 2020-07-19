# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
companies = Company.all
companies.each do |company|
	next if company.zip_code.blank?
	city_state_data = ZipCodes.identify(company.zip_code)
  if city_state_data.present?
    company.city = city_state_data[:city]
    company.state = city_state_data[:state_code]
    company.save
  end
end
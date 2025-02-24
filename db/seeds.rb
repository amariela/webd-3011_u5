# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# require 'faker'

# 676.times do
#   Product.create(
#     title: Faker::Commerce.product_name,
#     price: Faker::Commerce.price(range: 1..1000.0),
#     stock_quantity: Faker::Number.within(range: 1..200)
#   )
# end

require 'csv'
csv_file = Rails.root.join('db/products.csv')
csv_data = File.read(csv_file)
products = CSV.parse(csv_data, headers: true)

products.each do |product|
  category = Category.find_or_create_by(name: product["category"])
  product = Product.create(
    title: product["name"],
    price: product["price"],
    description: product["description"],
    stock_quantity: product["stock quantity"],
    category_id: category.id
  )
  puts product.persisted? ? "Successfully created #{product["title"]} in database." : "Error creating #{product["title"]}: #{roduct.errors.full_messages}"
end

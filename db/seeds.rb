# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

Comment.destroy_all
Post.destroy_all
User.destroy_all

puts "Creating users..."
Fanny = User.create(email: "fanny@gmail.com", password: "reglisse", nickname: "fanny")
users = [Fanny]
10.times do
  users << User.create!(
    email: Faker::Internet.unique.email,
    password: "password",
    nickname: Faker::Internet.unique.username(specifier: 3..10)
  )
end

puts "Created #{users.count} users."


puts "Creating posts..."
posts = []
20.times do
  posts << Post.create!(
    user: users.sample,
    title: Faker::Book.title,
    content: Faker::Hipster.paragraph(sentence_count: 5),
    url: Faker::Internet.url
  )
end

puts "Created #{posts.count} posts."


puts "Creating comments..."
posts.each do |post|
  rand(3..8).times do
    Comment.create!(
      user: users.sample,
      post: post,
      content: Faker::Hipster.sentence(word_count: rand(10..20))
    )
  end
end

puts "Created #{Comment.count} comments."

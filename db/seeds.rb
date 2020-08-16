
# # # User.destroy_all
# # # City.destroy_all
# # # Gossip.destroy_all
# # # PrivateMessage.destroy_all
# # # Comment.destroy_all
# # # GossipTag.destroy_all
# # # Tag.destroy_all

10.times do |i|
  City.create(
    name: Faker::Address.city,
    zip_code: Faker::Address.zip_code,
  )
end

puts "Cities created!"

10.times do |i|
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.sentence(word_count: 10, supplemental: true, random_words_to_add: 10),
    email: Faker::Internet.email,
    age: rand(18..75),
    city: City.all.sample,
  )
end
puts "Users created!"

20.times do |i|
  Gossip.create(
    title: Faker::Movie.title[0..11],
    content: Faker::Quote.matz,
    user: User.all.sample,
  )
end
puts "Gossips created!"

10.times do
  title = Faker::Dessert.variety.strip.downcase
  title.gsub!(/\s+/, '-')
  Tag.create(
    title: title,
  )
end
puts "Tags created!"

30.times do |i|
  GossipTag.create(
    tag: Tag.all.sample,
    gossip: Gossip.all.sample,
  )
end
puts "GossipsTags created!"

15.times do |i|
  PrivateMessage.create(
    recipient: User.all.sample,
    sender: User.all.sample,
    content: Faker::Movie.quote,
  )
end
puts "PrivateMessages created!"

500.times do |i|
  Comment.create(
    content:  Faker::Quote.matz,
    commentable: Gossip.all.sample,
    user: User.all.sample
  )
end
puts "Comments gossips created!"

500.times do |i|
  Comment.create(
    content:  Faker::Quote.matz,
    commentable: Comment.all.sample,
    user: User.all.sample
  )
end
puts "Comments comments created!"


1000.times do |i|
  Like.create(
    user: User.all.sample,
    gossip: Gossip.all.sample
  )
end
puts "Like gossips created!"

2000.times do |i|
  Like.create(
    user: User.all.sample,
    comment: Comment.all.sample
  )
end
puts "Like comments created!"
require 'faker'
require 'open-uri'
namespace :db do
  desc 'TODO'

  task populate_fake_data: :environment do
    puts 'Populating database'
    Rake::Task['db:make_users'].execute
    Rake::Task['db:make_destinations'].execute
    Rake::Task['db:make_trips'].execute
    Rake::Task['db:make_posts'].execute
    puts 'Finished populating database'
  end

  task make_users: :environment do
    create_list(:user, 50)
    User.create(email: 'admin@admin.com', password: 'admin', first_name: 'TravelBlog', last_name: 'Administrator',
                dob: '1990-01-01', description: 'Admin', phone: '1234567890')
    puts 'Users created'
  end

  task make_destinations: :environment do
    create_list(:destination, 30)
    puts 'Destinations created'
  end

  task make_trips: :environment do
    build_list(:trip, 30) do |trip|
      trip.author = User.find(rand(1..30)).id
      trip.save!
    end
    puts 'Trips created'
  end

  task make_posts: :environment do
    build_list(:post, 30) do |post, i|
      post.trip = Trip.find(rand(1..30))
      post.author = User.find(post.trip.author)
      post.save!
      rand(1..6).times do
        r = rand(1..30)
        post.users << User.find(r) unless post.users.include?(User.find(r)) || post.author == User.find(r)
      end
      rand(1..6).times do
        r = rand(1..30)
        post.destinations << Destination.find(r) unless post.destinations.include?(Destination.find(r))
      end
      post.save!
    end
    puts 'Posts created'
  end

  task again: :environment do
    puts 'Deleting all data'
    Rake::Task['db:drop'].execute
    puts 'Creating database'
    Rake::Task['db:create'].execute
    puts 'Migrating database'
    Rake::Task['db:migrate'].execute
    puts 'Populating database'
    Rake::Task['db:populate_fake_data'].execute
    puts 'Finished'
  end

  task what: :environment do
    Trip.all.each do |trip|
      puts trip.name
      puts trip.description
      trip.posts.each do |post|
        puts post.title
        puts post.body
      end
    end
  end
end

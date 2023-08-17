# frozen_string_literal: true
require 'securerandom'
require 'faker'
require 'csv'
require 'open-uri'
table = CSV.parse(File.read("#{__dir__}/worldcities.csv"), headers: true)


def randomizer
  rand(1..42_905)
end
include FactoryBot::Syntax::Methods
FactoryBot.define do
  factory :media do
    
  end

  factory :audio do
    
  end

  factory :video do
    
  end

  factory :photo do
    
  end

  factory :api_key do
    
  end

  factory :user, class: 'User' do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { SecureRandom.alphanumeric(8) }
    email { Faker::Internet.unique.email }
    phone { rand(10**9..10**10).to_s }
    dob {Faker::Date.birthday(min_age: 18, max_age: 65)}
    description {Faker::ChuckNorris.fact}
  end

  factory :trip, class: 'Trip' do
    name { Faker::Book.title }
    description { Faker::Quote.famous_last_words }
    start_date { Faker::Date.between(from: 5.days.ago, to: 2.years.after) }
    end_date { start_date + rand(1..30).days }
  end

  factory :destination do #42906 ciudades en csv
    name { Faker::Restaurant.name }
    city {table[randomizer]['city_ascii']}
    latitude {table[randomizer]['lat']}
    longitude {table[randomizer]['lng']}
    country {table[randomizer]['country']}

  end

  factory :post, class: 'Post' do
    title { Faker::Book.title }
    body { Faker::ChuckNorris.fact }


  end

end





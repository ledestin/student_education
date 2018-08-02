FactoryBot.define do
  factory :teacher do
    name { Faker::StarWars.unique.character }
  end

  factory :student do
    name { Faker::StarWars.unique.character }
    completed_lesson 1
    completed_part 1
  end
end

FactoryBot.define do
  factory :teacher do
    name "MyString"
  end
  factory :student do
    name "MyString"
    completed_lesson 1
    completed_part 1
  end
end

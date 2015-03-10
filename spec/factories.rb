FactoryGirl.define do
  factory :user do
    name "Samu"
    birthdate Date.new(1992, 8, 27)
  end

  factory :assigment do
    name "Tee rori-labra"
    user
    is_done false
    deadline Date.new(2015, 4, 30)
  end
end

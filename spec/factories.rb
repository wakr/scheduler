FactoryGirl.define do
  factory :user do
    name "Samu"
    birthdate Date.new(1992, 8, 27)
    password "Test1"
    password_confirmation "Test1"
  end

  factory :assignment do
    name "Tee rori-labra"
    is_done false
    deadline Date.new(2015, 4, 30)
  end

  factory :task do
    name "Väsää angularilla single-page-app"
    location "Kumpula"
    is_done true
    assignment
  end

  factory :group do
    name "Test group"
    description "the most tested group in the world"
  end

  factory :membership do
    user
    group
  end

  factory :user_assignment do
    user
    assignment
    creator_id 27 #not real, but allows tests pass :D
  end

end

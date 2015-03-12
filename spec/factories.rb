FactoryGirl.define do
  factory :user do
    name "Samu"
    birthdate Date.new(1992, 8, 27)
  end

  factory :assignment do
    name "Tee rori-labra"
    is_done false
    deadline Date.new(2015, 4, 30)
  end

  factory :task do
    name "Väsää angularilla single-page-app"
    location "Kumpula"
    assignment
  end
end

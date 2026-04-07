FactoryBot.define do
  factory :channel do
    sequence(:name) { |n| "channel-#{n}" }
  end
end

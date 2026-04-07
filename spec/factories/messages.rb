FactoryBot.define do
  factory :message do
    content { "Hello world!" }
    channel
    user
  end
end

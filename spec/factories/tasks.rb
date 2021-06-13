FactoryBot.define do
  factory :task do
    title { 'task' }
    details { 'test' }
    limit { DateTime }
  end
end

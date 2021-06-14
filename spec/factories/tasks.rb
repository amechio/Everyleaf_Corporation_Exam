FactoryBot.define do
  factory :task do
    title { 'task' }
    details { 'test' }
    limit { '2021-06-20' }
  end
  factory :second_task, class: Task do
    title { 'task2' }
    details { 'test2' }
    limit { '2021-06-18' }
  end
end

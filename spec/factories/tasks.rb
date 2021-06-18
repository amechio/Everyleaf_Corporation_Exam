FactoryBot.define do
  factory :task do
    title { 'task' }
    details { 'test' }
    limit { '2021-06-20' }
    status { '完了' }
    priority { '高' }
    association :user
  end
  factory :second_task, class: Task do
    title { 'task2' }
    details { 'test2' }
    limit { '2021-06-18' }
    status { '未着手' }
    priority { '低' }
    association :user
  end
end

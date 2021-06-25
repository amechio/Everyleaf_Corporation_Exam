FactoryBot.define do
  factory :task do
    title { 'task' }
    details { 'test' }
    limit { '2021-06-30' }
    created_at { '2021-06-1' }
    status { '完了' }
    priority { '高' }
    association :user
    after(:build) do |task|
      label = create(:label)
      task.labellings << build(:labelling, task: task, label: label)
    end
  end
  factory :second_task, class: Task do
    title { 'task2' }
    details { 'test2' }
    limit { '2021-06-29' }
    created_at { '2021-06-21' }
    status { '未着手' }
    priority { '低' }
    association :user
  end
end

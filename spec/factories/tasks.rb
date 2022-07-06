FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    deadline { '002022-07-01' }
    status { 'waiting' }
    priority { 'low' }
  end
  factory :second_task, class: Task do
    title { 'test_title2' }
    content { 'test_content2' }
    deadline { '002022-07-02' }
    status { 'doing' }
    priority { 'medium' }
  end
  factory :third_task, class: Task do
    title { 'test_title3' }
    content { 'test_content3' }
    deadline { '002022-07-03' }
    status { 'done' }
    priority { 'high' }
  end
end
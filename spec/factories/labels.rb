FactoryBot.define do
  factory :label do
    label_name { 'label-1' }
  end
  factory :label_2, class: Label do
    label_name { 'label-2' }
  end
  factory :label_3, class: Label do
    label_name { 'label-3' }
  end
  factory :label_4, class: Label do
    label_name { 'label-4' }
  end
  factory :label_5, class: Label do
    label_name { 'label-5' }
  end
end

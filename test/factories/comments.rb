FactoryBot.define do
  sequence :commenter do |n|
    "Commenter #{n}"
  end
  sequence :body do |n|
    "Body #{n}"
  end
  sequence :article_id do |n|
    n
  end
end

FactoryBot.define do
  factory :comment do
    commenter
    body
    article_id
  end
end

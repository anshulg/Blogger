Factory.define :blogpost do |blogpost|
  blogpost.title    "Lorem Ipsum 1"
  blogpost.content  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tristique mattis pellentesque. Nullam laoreet malesuada urna"
end

Factory.define :rating do |rating|
  rating.score 3
  rating.association :blogpost
end

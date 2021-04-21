Factory.define(:project) do |f|
  f.sequence(:name) { |n| "Project ##{n}" }
end

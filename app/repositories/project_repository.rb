class ProjectRepository < ApplicationRepository[:projects]
  commands :create, update: :by_pk, delete: :by_pk
end

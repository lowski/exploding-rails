class ProjectRepository < ApplicationRepository[:projects]
  # TODO: Switch to
  # commands :build, :create, update: :by_pk, delete: :by_pk
  commands :create, update: :by_pk, delete: :by_pk
end

class Collaboration < ActiveRecord::Base
  belongs_to :project
  belongs_to :collaborator
  validates :collaborator_id, uniqueness: { scope: :project_id }
end

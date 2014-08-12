class Project < ActiveRecord::Base
  has_many :collaborations
  has_many :collaborators, through: :collaborations
  validates :collaborators, length: { minimum: 1,
                                      maximum: 4,
                                      too_short: 'must have at least one collaborator',
                                      too_long: 'can not have more than 4 Collaborators'
                                    }

  def done?
    github_url && heroku_url
  end

  def add_collaborator(github_username)
    self.collaborators << Collaborator.from_github_username(github_username)
  end
end

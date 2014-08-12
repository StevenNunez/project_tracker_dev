class Collaborator < ActiveRecord::Base
  has_many :collaborations
  has_many :projects, through: :collaborations
  validates :github_username, presence: true, uniqueness: true
  validate :collaborations, uniqueness: { scope: :project_id }

  def self.from_github_username(github_username)
    collaborator = Collaborator.find_by(github_username: github_username)
    if collaborator.nil?
      user_hash = JSON.parse(RestClient.get("https://api.github.com/users/#{github_username}"))
      name = user_hash['name']
      collaborator = Collaborator.create(github_username: github_username, name: name)
    end
    collaborator
  end

  def add_project(project)
    self.projects << project
  end
end

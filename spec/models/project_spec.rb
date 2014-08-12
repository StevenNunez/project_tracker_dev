require 'rails_helper'

RSpec.describe Project, :type => :model do
  context "Done status" do
    it "is not done by default" do
      project = Project.new
      expect(project.done?).to be_falsy
    end

    it "is not done if only github_url is present" do
      project = Project.new
      project.github_url = "https://github.com/StevenNunez/stevennunez.github.io"
      expect(project.done?).to be_falsy
    end

    it "is not done if only heroku_url is present" do
      project = Project.new
      project.heroku_url = "http://hostiledeveloper.com"
      expect(project.done?).to be_falsy
    end

    it "is done when both github_url and heroku_url are present" do
      project = Project.new
      project.github_url = "https://github.com/StevenNunez/stevennunez.github.io"
      project.heroku_url = "http://hostiledeveloper.com"
      expect(project.done?).to be_truthy
    end
  end

  describe "Validations" do
    it "must have a minimum of one collaborator" do
      project = Project.new
      expect(project.invalid?).to be_truthy
      expect(project.errors[:collaborators]).to include("must have at least one collaborator")
    end

    it "is valid with one collaborator" do
      project = Project.new
      project.collaborators << FactoryGirl.build(:collaborator)
      expect(project.valid?).to be_truthy
    end

    it "is invalid if it has more than 4 collaborators" do
      project = Project.new
      5.times do
        project.collaborators << FactoryGirl.build(:collaborator)
      end
      expect(project.invalid?).to be_truthy
      expect(project.errors[:collaborators]).to include("can not have more than 4 Collaborators")
    end
  end

  describe "Adding Collaborators" do
    it "finds existing collaborator by username if they exist" do
      project = Project.new
      Collaborator.create! name: 'Blake Johnson', github_username: 'Blake41'
      project.add_collaborator('Blake41')
      collaborator = project.collaborators.first

      expect(collaborator).to_not be_nil
      expect(collaborator.name).to eq('Blake Johnson')
      expect(project.collaborators).to include(collaborator)
    end

    it "creates a new collaborator if they don't already exist" do
      project = Project.new
      VCR.use_cassette('steven_github_user') do
        project.add_collaborator('StevenNunez')
      end
      collaborator = Collaborator.find_by github_username: 'StevenNunez'

      expect(collaborator).to_not be_nil
      expect(collaborator.name).to eq('Steven Nunez')
      expect(project.collaborators).to include(collaborator)
    end
  end
end

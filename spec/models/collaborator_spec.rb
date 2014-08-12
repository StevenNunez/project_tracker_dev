require 'rails_helper'

RSpec.describe Collaborator, :type => :model do
  describe "Validations" do
    it "is invalid without a github_username" do
      collaborator = Collaborator.new
      expect(collaborator.invalid?).to be_truthy
      expect(collaborator.errors[:github_username]).to include("can't be blank")
    end

    it "has unique github_usernames" do
      Collaborator.create!(github_username: "StevenNunez")
      collaborator = Collaborator.new(github_username: "StevenNunez")
      expect(collaborator.invalid?).to be_truthy
      expect(collaborator.errors[:github_username]).to include("has already been taken")
    end

    it "prevents users from having the same project added twice" do
      collaborator = Collaborator.new(github_username: "StevenNunez")
      slide_hero = FactoryGirl.create(:project, name: "Slide Hero", collaborators: [collaborator])
      expect do
        collaborator.add_project(slide_hero)
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "Fetching User by github_username" do
    it "finds a user if they exist in the db" do
      c = Collaborator.create!(github_username: "StevenNunez", name: "Steven Nunez")
      c_from_db = {}

      VCR.use_cassette('steven_github_user') do
        c_from_db = Collaborator.from_github_username('StevenNunez')
      end

      expect(c).to eq(c_from_db)
    end
  end
end

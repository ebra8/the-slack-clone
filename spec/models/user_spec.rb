require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it "has many messages" do
      expect(User.reflect_on_association(:messages).macro).to eq(:has_many)
    end

    it "has many channel_users" do
      expect(User.reflect_on_association(:channel_users).macro).to eq(:has_many)
    end

    it "has many channels" do
      expect(User.reflect_on_association(:channels).macro).to eq(:has_many)
    end
  end

  describe "validations" do
    it "is valid with valid attributes" do
      expect(build(:user)).to be_valid
    end

    it "is not valid without an email" do
      expect(build(:user, email: nil)).not_to be_valid
    end
  end
end

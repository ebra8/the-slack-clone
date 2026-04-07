require 'rails_helper'

RSpec.describe Channel, type: :model do
  describe "associations" do
    it "has many messages" do
      expect(Channel.reflect_on_association(:messages).macro).to eq(:has_many)
    end

    it "has many channel_users" do
      expect(Channel.reflect_on_association(:channel_users).macro).to eq(:has_many)
    end

    it "has many users" do
      expect(Channel.reflect_on_association(:users).macro).to eq(:has_many)
    end
  end

  describe "validations" do
    it "is valid with a name" do
      expect(build(:channel)).to be_valid
    end

    it "is not valid without a name" do
      expect(build(:channel, name: nil)).not_to be_valid
    end
  end
end

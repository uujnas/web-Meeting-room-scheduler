require "rails_helper"

RSpec.describe User, type: :model do
  context "associations" do
    it { should have_many(:rooms).class_name("Room") }
  end
end

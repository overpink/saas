require 'rails_helper' 

describe User do
  it { should have_many(:comments).with_foreign_key(:author_id) }
  it { should have_many(:roles) }

  it "should have a valid factory" do
    expect(build(:user)).to be_valid
  end
end
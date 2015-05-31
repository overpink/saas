require 'rails_helper' 

describe Comment do
  it { should belong_to :owner }
  it { should belong_to(:author).class_name('User')}
  it { should validate_presence_of :content }

  it "should have a valid factory" do
    expect(build(:comment)).to be_valid
  end
end
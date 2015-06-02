require 'rails_helper'

describe Task do
  it { should belong_to :project }
  it { should have_many :comments }
  it { should validate_presence_of :project_id }
  it { should validate_presence_of :content }

  it "should have a valid factory" do
    expect(build(:task)).to be_valid
  end
end
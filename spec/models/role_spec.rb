require 'rails_helper'

describe Role do
  it { should have_and_belong_to_many :users }
  it { should belong_to :resource }
  it { should validate_inclusion_of(:resource_type).in_array(Rolify.resource_types).allow_nil }

  it "should have a valid factory" do
    expect(build(:role)).to be_valid
  end
end
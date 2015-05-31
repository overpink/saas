require 'rails_helper'

describe Project do
  it { should belong_to :tenant }
  it { should have_many :roles }
  it { should have_many(:members).through(:roles).source(:users) }
  it { should have_many :tasks }
  it { should have_many :comments }
  it { should validate_presence_of :name}

  it "should have a valid factory" do
    expect(build(:project)).to be_valid
  end

  describe "#ensure_slug" do
    before(:each) do
      @project = build(:project, slug: nil)
      @project.save!
    end

    it "should set a slug" do
      expect(@project.slug).to_not be_nil
    end

    it "should set name parametize as slug" do
      expect(@project.slug).to eq(@project.name.parameterize)
    end
  end
end
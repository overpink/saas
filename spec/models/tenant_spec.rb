require 'rails_helper'

describe Tenant do
  it { should have_many :roles }
  it { should have_many(:collaborators).through(:roles).source(:users) }
  it { should have_many :projects }
  it { should validate_presence_of :name }
  it { should validate_presence_of :slug }

  it "should have a valid factory" do
    expect(build(:tenant)).to be_valid
  end

  describe "#ensure_log" do
    before(:each) do
      @tenant = build(:tenant, slug: nil)
      @tenant.save!
    end

    it "should set a slug" do
      expect(@tenant.slug).to_not be_nil
    end

    it "should set name parametize as slug" do
      expect(@tenant.slug).to eq(@tenant.name.parameterize)
    end
  end
end
class Project < ActiveRecord::Base
  resourcify
  belongs_to :tenant
  has_many :roles, as: :resource
  has_many :members, through: :roles, source: :users

  has_many :tasks
  has_many :comments, as: :owner

  scope :in_tenant, ->(tenant) { where(tenant_id: tenant.id)}


  before_validation :ensure_slug

  def ensure_slug
    self.slug = self.name.parameterize if self.slug.blank? && self.name.present?
  end


end

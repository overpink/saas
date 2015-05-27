class Tenant < ActiveRecord::Base
  resourcify

  has_many :roles, as: :resource
  has_many :collaborators, through: :roles, source: :users

  has_many :projects

  validates :name, :slug, presence: true

  before_validation :ensure_slug

  def ensure_slug
    self.slug = self.name.parameterize if self.slug.blank? && self.name.present?
  end

  def url(path='')
    "http://#{self.slug}.saas.dev#{path}"
  end
end

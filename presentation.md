projects:
  tenant_id:integer
  name:string
  description:string
  slug:string

tasks:
  project_id:integer
  content:text
  status:integer
  user_id:integer
  author_id:integer

comments:
  owner_type:string
  owner_id:integer
  content:text
  author_id:integer

users:
  email:string
  name:string
  # authentication stuff


#Rolify stuff:

roles:
  name:string
  resource_id:integer
  resource_type:string

users_roles:
  user_id:integer
  role_id:integer


tenant:
  name:string
  description:text
  slug:string



rails g scaffold project tenant_id:integer name:string description:string slug:string

rails g scaffold task project_id:integer content:text status:integer user_id:integer author_id:integer

rails g scaffold comment owner_type:string owner_id:integer content:text author_id:integer

rails g scaffold tenant name:string description:text slug:string


#=================================

# user.rb
class User < ActiveRecord::Base
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

# tenant.rb
class Tenant < ActiveRecord::Base
  resourcify

  has_many :roles, as: :resource
  has_many :collaborators, through: :roles, source: :users

  has_many :projects
end

# project.rb
class Project < ActiveRecord::Base
  resourcify
  belongs_to :tenant
  has_many :roles, as: :resource
  has_many :members, through: :roles, source: :users

  has_many :tasks
  has_many :comments, as: :owner
end

# task.rb
class Task < ActiveRecord::Base
  enum status: [:iced, :todo, :done, :archived]
  belongs_to :project
  has_many :comments, as: :owner
end

# comment.rb
class Comment < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
end


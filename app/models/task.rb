class Task < ActiveRecord::Base
  enum status: [:iced, :todo, :done, :archived]
  belongs_to :project
  has_many :comments, as: :owner

end

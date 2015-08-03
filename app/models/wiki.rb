class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :users, through: :collaborators
  has_many :collaborators

  default_scope { order('wikis.created_at DESC') }
  
  scope :visible_to, -> (user) { user && ((user.role == "admin") || (user.role == "premium_user")) ? all : where(private: false)}
end

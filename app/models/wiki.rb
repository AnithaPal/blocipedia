class Wiki < ActiveRecord::Base
  belongs_to :user
  default_scope { order('created_at DESC') }
  scope :visible_to, -> (user) { user && ((user.role == "admin") || (user.role == "premium_user")) ? all : where((private == false) || (private == nil))}
  
end

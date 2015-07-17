class Collaborator < ActiveRecord::Base
  belongs_to :wiki
  belongs_to :user


  validates_uniqueness_of :user_id, scope: :wiki_id, message: " is already a collaborator"
end

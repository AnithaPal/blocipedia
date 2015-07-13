class WikiPolicy < ApplicationPolicy
  

  def index?
    true
  end 

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end 

  def show?
    (user.present? && ((user.role == 'premium_user') || (user.role == 'admin'))) || record.private == false
   end
end
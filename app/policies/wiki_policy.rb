class WikiPolicy < ApplicationPolicy
  

  def index?
    user.present?
  end 

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end 

  def show?
    user.present? && (user.premium_user? || user.admin? || record.private != true)
  end
   
end
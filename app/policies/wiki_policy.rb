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
   
   class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    
    def resolve
    wikis = []
    if user.role == 'admin'
      wikis = scope.all
    elsif user.role = "premium_user"
      all_wikis = scope.all
      all_wikis.each do |wiki|
        if wiki.private == false || wiki.user == user || wiki.users.include?(user)
          wikis << wiki
        end
      end
    else
      all_wikis = scope.all  
      all_wikis.each do |wiki|
        if wiki.private == false || wiki.users.include?(user)
          wikis << wiki
        end
      end        
    end
    return wikis
    end 
  end
end     

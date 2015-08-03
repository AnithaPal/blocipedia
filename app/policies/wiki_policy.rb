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
      return scope.where(private: false) unless user

      if user.role == 'admin'
        scope.all
      elsif user.role = "premium_user"
        scope.eager_load(:collaborators).where("wikis.private = ? OR wikis.user_id = ? OR collaborators.user_id = ?", false, user.id, user.id)
      else
        scope.eager_load(:collaborators).where("wikis.private = ? OR collaborators.user_id = ?", false, user.id)
      end
    end
  end
end

class PaymentPolicy < AdminUserPolicy
  
  def index?
    @user.admin?
  end
  
  def show?
    @user.admin?
  end
  
  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end

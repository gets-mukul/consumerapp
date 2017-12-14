class DoctorPolicy < AdminUserPolicy
  
  def index?
    @user.admin?
  end
  
  def show?
    @user.admin?
  end

  def create?
    @user.admin?
  end

  def new?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def edit?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end

  def batch_action?
    @user.admin?
  end
  
  def change?
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
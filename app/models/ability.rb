class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    end

    if user.manager?
      can :manage, User
      can :manage, Customer
      can :manage, Project
    end
  end
end

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

    if user.programmer?
      can :manage, Task, user_id: user.id
      can :manage, TimeEntry, user_id: user.id
    end
  end
end

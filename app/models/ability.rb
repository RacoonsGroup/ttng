class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
      cannot :create, Task
      cannot :create, TimeEntry
    end

    if user.manager?
      can :manage, User
      can :manage, Customer
      can :manage, Project
      can :read, Task
      can :read, TimeEntry
    end

    if user.developer?
      can :manage, Task, user_id: user.id
      can :manage, TimeEntry, user_id: user.id
    end
  end
end

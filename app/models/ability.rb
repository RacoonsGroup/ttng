class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
      cannot :create, RelatedTask
      cannot :create, TimeEntry
    end

    if user.manager?
      can :manage, User
      can :manage, Customer
      can :manage, Project
      can :manage, Day
      can :manage, Comment
      can :read, RelatedTask
      can :read, TimeEntry
    end

    if user.developer?
      can :manage, RelatedTask, user_id: user.id
      can :manage, TimeEntry, user_id: user.id
      can :manage, Article, user_id: user.id
      can :manage, Comment
      can :read, Project
      can :read, User
      can [:read, :unread], Article
    end

    if user.customer?
      can :read, RelatedTask
      can :manage, Comment
      can :read, Project
      can :read, User
    end
  end
end

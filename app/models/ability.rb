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
      can :manage, Contact
      can :manage, Project, id: user.project_ids 
      can :create, Project
      can :manage, ProjectPresenter
      can :manage, Day
      can :manage, Comment, project: { id: user.project_ids }
      can :read, RelatedTask
      can :read, TimeEntry
    end

    if user.developer?
      can :manage, RelatedTask, user_id: user.id
      can :manage, TimeEntry, user_id: user.id
      can :manage, Article, user_id: user.id
      can :manage, Comment, form: "developer", project: { id: user.project_ids }
      can :read, Comment, form: "general", project: { id: user.project_ids }
      can :read, Project
      can :read, Contact
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

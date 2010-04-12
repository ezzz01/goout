class Ability
    include CanCan::Ability

    def initialize(user)
      user ||= User.new # guest user
      admin = Role.find_by_title('admin')
      if user.roles.include?(admin)
        can :manage, :all
      else
        can :read, :all

        can :create, [Comment, User, Question]

        #workaroud for custom action via AJAX call. Permission is checked in action
        can :mark_as_deleted, :all

        if user.try(:username)
          can :create, [Activity, Post, Concept, Revision]
        end

        can [:update, :destroy], User do |edit_user|
          edit_user == user
        end

        can [:update, :destroy], Post do |post|
            post.try(:user) == user
        end

        can [:update, :destroy], Activity do |activity|
            activity.user == user
        end

        can :destroy, Comment do |comment|
            comment.try(:user) == user || comment.try(:post).try(:user) == user
        end
      end


  end
end

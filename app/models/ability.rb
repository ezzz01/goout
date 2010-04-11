class Ability
    include CanCan::Ability

    def initialize(user)
      user ||= User.new # guest user
      admin = Role.find_by_title('admin')
      if user.roles.include?(admin)
        can :manage, :all
      else
        can :read, :all
        can :create, [Comment, User, Post, Activity, Concept]

        can :update, User do |edit_user|
          edit_user == user
        end

        can :update, Post do |post|
            post.user == user
        end

        can :destroy, Post do |post|
            post.user == user
        end

        can :destroy, Activity do |activity|
            activity.user == user
        end

        can :destroy, Comment do |comment|
            comment.user == user || comment.post.user == user
        end
      end


  end
end

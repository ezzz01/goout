class Ability
    include CanCan::Ability

    def initialize(user)
      user ||= User.new # guest user
      admin = Role.find_by_title('admin')
      if user.roles.include?(admin)
        can :manage, :all
      else
        can :read, :all
        can :create, Comment

        can :update, Post do |post|
        puts post
            post.user == user
        end

        can :destroy, Post do |post|
            post.user == user
        end

        can :destroy, Comment do |comment|
            comment.user == user || comment.post.user == user
        end
      end


  end
end

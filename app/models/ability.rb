class Ability
    include CanCan::Ability

    def initialize(user)
      admin = Role.find_by_title('admin')
      if user.roles.include?(admin)
        can :manage, :all
      else
        can :read, :all
    end
  end
end

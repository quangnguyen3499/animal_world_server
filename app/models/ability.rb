class Ability
  include CanCan::Ability

  def initialize user, params
    @user = user
    @params = params

    return unless @user

    if @user.admin?
      can :manage, :all
    else
      can :read, Place
      can :manage, User, id: @user.id
    end
  end
end

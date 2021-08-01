class Ability
  include CanCan::Ability

  def initialize company_admin, params
    @user = company_admin
    @params = params

    return unless @user

    if @user.admin?
      can :manage, :all
    else
      can :read, [Company, Client]
      can :manage, Item
      can :read, :update, CompanyAdmin, id: @user.id
    end
  end
end

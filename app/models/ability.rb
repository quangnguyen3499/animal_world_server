class Ability
  include CanCan::Ability

  def initialize company_admin, params
    @user = company_admin
    @params = params

    return unless @user

    if @user.admin?
      can :manage, Item
      check_role_company_admin
    else
      # can :manage, Employee, company_id: @user.company_id
      # can [:edit, :read, :update_profile], Company, id: @user.company_id
      # can :read, CompanyAdmin, company_id: @user.company_id
      # can :update, CompanyAdmin, id: @user.id
      # can :read, Billing, company_id: @user.company_id
      # check_role_energizer if @params[:employee_id]
    end
  end

  def check_role_energizer
    employee = Employee.find_by(id: @params[:employee_id])
    can :manage, Energizer if employee&.company_id == @user.company_id
  end

  def check_role_company_admin
    can :manage, CompanyAdmin
    return if @user.admin?

    admin = @user.admin
    cannot :update, admin
  end
end

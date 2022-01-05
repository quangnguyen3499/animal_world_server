ActiveAdmin.register User do
  filter :email
  filter :username
  filter :role
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :provider, :uid, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :allow_password_change, :remember_created_at, :username, :role, :tokens
  #
  # or
  #
  permit_params do
    permitted = [:provider, :uid, :email, :encrypted_password, :username, :role]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  config.sort_order = "id_asc"

  index do
    selectable_column
    column :id
    column :email
    column :username
    column :role
    actions
  end
end

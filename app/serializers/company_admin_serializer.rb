# == Schema Information
#
# Table name: company_admins
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  discarded_at           :datetime
#  email                  :string(191)      default(""), not null
#  encrypted_password     :string(191)      default(""), not null
#  first_name             :string(191)
#  last_name              :string(191)
#  provider               :string(191)      default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(191)
#  role                   :integer
#  tokens                 :text(65535)
#  uid                    :string(191)      default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_company_admins_on_discarded_at          (discarded_at)
#  index_company_admins_on_email                 (email) UNIQUE
#  index_company_admins_on_reset_password_token  (reset_password_token) UNIQUE
#  index_company_admins_on_uid_and_provider      (uid,provider) UNIQUE
#
class CompanyAdminSerializer < ApplicationSerializer
  attribute :user do |object, params|
    is_daihyo = params[:is_daihyo]
    {
      id: object.id,
      email: object.email,
      first_name: object.first_name,
      last_name: object.last_name,
      role: object.role,
      created_at: object.created_at.strftime("%d/%m/%Y"),
      updated_at: object.updated_at.strftime("%d/%m/%Y")
    }
  end

  attribute :token do |object, params|
    token = params[:token]
    {
      uid: object.uid,
      token: token.token,
      client_id: token.client,
      expiry: token.expiry
    }
  end
end

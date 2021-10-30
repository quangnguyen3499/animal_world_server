# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
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
#  url_avatar             :string(191)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
class UserSerializer < ApplicationSerializer
  attribute :user do |object, _params|
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
end

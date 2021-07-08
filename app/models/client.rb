# == Schema Information
#
# Table name: clients
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  discarded_at           :datetime
#  email                  :string(191)      default(""), not null
#  encrypted_password     :string(191)      default(""), not null
#  first_name             :string(191)
#  last_name              :string(191)
#  member_level           :integer
#  provider               :string(191)      default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(191)
#  tokens                 :text(65535)
#  uid                    :string(191)      default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_clients_on_discarded_at          (discarded_at)
#  index_clients_on_email                 (email) UNIQUE
#  index_clients_on_reset_password_token  (reset_password_token) UNIQUE
#  index_clients_on_uid_and_provider      (uid,provider) UNIQUE
#
class Client < ApplicationRecord
  extend Devise::Models
  devise :database_authenticatable, :registerable, :recoverable
  include DeviseTokenAuth::Concerns::User

  CREATE_PARAMS = [:first_name, :last_name, :email, :member_level, :password]

  before_validation :sync_uid

  enum member_level: {regular: 0, VIP1: 1, VIP2: 2, VIP3: 3}

  validates :first_name, :last_name, presence: true, length: {maximum: 100}
  validates :email, presence: true, format: {with: Settings.regx.email_rule}
  validates :email, uniqueness: {scope: :provider, case_sensitive: false}

  def sync_uid
    self.uid = email if provider == "email"
  end

  def active_for_authentication?
    super && !discarded?
  end
end

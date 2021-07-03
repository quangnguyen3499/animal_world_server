class Client < ApplicationRecord
  extend Devise::Models
  devise :database_authenticatable, :registerable, :recoverable, :confirmable
  include DeviseTokenAuth::Concerns::User

  CREATE_PARAMS = [:first_name, :last_name, :email, :member_level, :password]

  before_validation :sync_uid

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

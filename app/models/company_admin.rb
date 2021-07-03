class CompanyAdmin < ApplicationRecord
  extend Devise::Models
  devise :database_authenticatable, :registerable, :recoverable
  include DeviseTokenAuth::Concerns::User

  before_discard do
    raise ApiError::Undeletable if admin
  end

  CREATE_PARAMS = [:first_name, :last_name, :email, :role, :password]

  enum role: {admin: 0, worker: 1}

  before_validation :sync_uid

  validates :first_name, :last_name, presence: true, length: {maximum: 100}
  validates :email, presence: true, format: {with: Settings.regx.email_rule}
  validates :email, uniqueness: {scope: :provider, case_sensitive: false}
  validates :role, presence: true

  def sync_uid
    self.uid = email if provider == "email"
  end

  def active_for_authentication?
    super && !discarded?
  end
end

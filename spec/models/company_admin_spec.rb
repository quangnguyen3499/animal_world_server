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
require 'rails_helper'

RSpec.describe CompanyAdmin, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

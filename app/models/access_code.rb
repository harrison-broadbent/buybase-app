# == Schema Information
#
# Table name: access_codes
#
#  id             :bigint           not null, primary key
#  code           :string
#  customer_email :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  dataset_id     :bigint           not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_access_codes_on_dataset_id  (dataset_id)
#  index_access_codes_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (dataset_id => datasets.id)
#  fk_rails_...  (user_id => users.id)
#
class AccessCode < ApplicationRecord
  belongs_to :user
  belongs_to :dataset

  after_create :email_access_code_to_customer

  def email_access_code_to_customer
    puts "MOCK: email access code (#{self.code}) to customer"
  end
end
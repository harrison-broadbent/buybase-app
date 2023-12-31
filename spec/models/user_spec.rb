# == Schema Information
#
# Table name: users
#
#  id                               :bigint           not null, primary key
#  email                            :string           default(""), not null
#  encrypted_password               :string           default(""), not null
#  image                            :string
#  name                             :string
#  provider                         :string
#  remember_created_at              :datetime
#  reset_password_sent_at           :datetime
#  reset_password_token             :string
#  stripe_checkout_percentage_fee   :float
#  stripe_connected_account_success :boolean
#  uid                              :string
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  connected_account_id             :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

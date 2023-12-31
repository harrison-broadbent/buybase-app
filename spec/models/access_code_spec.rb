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
require 'rails_helper'

RSpec.describe AccessCode, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

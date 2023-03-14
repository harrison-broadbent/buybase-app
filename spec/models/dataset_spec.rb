# == Schema Information
#
# Table name: datasets
#
#  id                :bigint           not null, primary key
#  database_url      :string
#  dataset_type      :integer
#  name              :string
#  price             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  stripe_price_id   :string
#  stripe_product_id :string
#  user_id           :bigint           not null
#
# Indexes
#
#  index_datasets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Dataset, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

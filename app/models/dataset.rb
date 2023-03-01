# == Schema Information
#
# Table name: datasets
#
#  id         :bigint           not null, primary key
#  name       :string
#  price      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_datasets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Dataset < ApplicationRecord
  belongs_to :user
  has_one_attached :file, dependent: :destroy
end

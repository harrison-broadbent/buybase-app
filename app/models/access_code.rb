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

require 'sendgrid-ruby'
include SendGrid
class AccessCode < ApplicationRecord
  belongs_to :user
  belongs_to :dataset

  validates_presence_of :code, :customer_email, :dataset_id, :user_id

  after_create :email_access_code_to_customer

  def email_access_code_to_customer
    dataset_url = "https://app.buybase.io/datasets/#{self.dataset.id}?customer_access_code=#{self.code}"
    json_data = {
      personalizations: [
        {
          to: [
            {
              email: self.customer_email
            }
          ],
          dynamic_template_data: {
            dataset_name: self.dataset.name,
            access_code: self.code,
            dataset_link: dataset_url
          }
        }
      ],
      from: {
        email: "support@buybase.io"
      },
      template_id: "d-de107572252c46499153a42418820d9c"
    }

    sg = SendGrid::API.new(api_key: Rails.application.credentials.sendgrid[:api_key])
    begin
      response = sg.client.mail._("send").post(request_body: json_data.to_json)
    rescue Exception => e
      puts e.message
    end
    puts response.status_code
  end
end

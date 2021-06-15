class PhoneNumber < ApplicationRecord
  # Table name in the database is phone_number instead of phone_numbers
  self.table_name = 'phone_number'

  # Association
  belongs_to :account
end

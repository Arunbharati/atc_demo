class Account < ApplicationRecord
  # Table name in the database is account instead of accounts
  self.table_name = 'account'

  # Association
  has_many :phone_numbers
end

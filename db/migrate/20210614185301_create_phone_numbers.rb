class CreatePhoneNumbers < ActiveRecord::Migration[6.1]
  def change
    create_table :phone_numbers do |t|

      t.timestamps
    end
  end
end

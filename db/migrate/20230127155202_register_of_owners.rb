class RegisterOfOwners < ActiveRecord::Migration[7.0]
  def change
    create_table :register_of_owners do |t|
      t.string :email,                      null: false, default: ""
      t.string :middle_name,                null: false, default: ""
      t.string :first_name,                 null: false, default: ""
      t.string :last_name,                  null: false, default: ""
      t.string :personal_account,           null: false, default: ""
      t.string :city,                       null: false, default: ""
      t.string :street,                     null: false, default: ""
      t.string :house_no,                   null: false, default: ""
      t.integer :apartment_no,              null: false, default: ""
      t.integer :number_owners,             null: false, default: ""
      t.string :phone,                      null: false, default: ""
      t.datetime :home_activation_date,     null: false, default: ""
      t.datetime :subscriber_blocking_date, null: false, default: ""
      t.string :contractor,                 null: false, default: ""
      t.string :serial_number,              null: false, default: ""

      t.timestamps
    end

    add_index :register_of_owners, :personal_account, unique: true
  end
end

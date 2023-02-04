class ServiceCancellations < ActiveRecord::Migration[7.0]
  def change
    create_table :service_cancellations do |t|
      t.string :middle_name,      null: false, default: ""
      t.string :first_name,       null: false, default: ""
      t.string :last_name,        null: false, default: ""
      t.datetime :date_rejection, null: false, default: ""

      t.timestamps
    end

    add_index :service_cancellations, :last_name, unique: true
    add_index :service_cancellations, :first_name, unique: true
    add_index :service_cancellations, :middle_name, unique: true
    add_reference :service_cancellations, :register_of_owners, foreign_key: true, null: false
  end
end

class AccessRegistries < ActiveRecord::Migration[7.0]
  def change
    create_table :access_registries do |t|
      t.string :login,                      null: false, default: ""
      t.string :password,                   null: false, default: ""
      t.datetime :date_application,         null: false, default: ""
      t.datetime :date_issue,               null: false, default: ""

      t.timestamps
    end

    add_index :access_registries, :password, unique: true
    add_reference :access_registries, :register_of_owners, foreign_key: true
  end
end

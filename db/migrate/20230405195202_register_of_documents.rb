class RegisterOfDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :register_of_documents do |t|
      t.string :city,     null: false, default: ""
      t.string :street,   null: false, default: ""
      t.string :house_no, null: false, default: ""

      t.timestamps
    end

    add_index :register_of_documents, :city
    add_index :register_of_documents, :street
    add_index :register_of_documents, :house_no
  end
end

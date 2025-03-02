class AddBoleanToRegisterOfOwners < ActiveRecord::Migration[7.0]
  def change
    add_column :register_of_owners, :debtor, :boolean, default: "false"
    add_column :register_of_owners, :condition, :boolean, default: "false"
  end
end

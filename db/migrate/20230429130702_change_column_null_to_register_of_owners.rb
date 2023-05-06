class ChangeColumnNullToRegisterOfOwners < ActiveRecord::Migration[7.0]
  def change
    change_column_null :register_of_owners, :serial_number, true
    change_column_null :register_of_owners, :contractor, true
    change_column_null :register_of_owners, :number_owners, true
    change_column_null :register_of_owners, :home_activation_date, true
    change_column_null :register_of_owners, :subscriber_blocking_date, true
  end
end

class AddSerialNumberToAccessRegistries < ActiveRecord::Migration[7.0]
  def change
    add_column :access_registries, :serial_number, :string
  end
end

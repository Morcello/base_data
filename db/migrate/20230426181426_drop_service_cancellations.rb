class DropServiceCancellations < ActiveRecord::Migration[7.0]
  def change
    drop_table :service_cancellations
  end
end

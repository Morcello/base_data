class AddStartAccrualDateToRegisterOfDocuments < ActiveRecord::Migration[7.0]
  def change
    add_column :register_of_documents, :start_accrual_date, :date
  end
end

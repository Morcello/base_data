class RemoveNullRegisterOfOwner < ActiveRecord::Migration[5.2]
  def change
    remove_reference :access_registrys, :register_of_owners, foreign_key: true
    add_reference :access_registrys, :register_of_owners, foreign_key: true
  end
end

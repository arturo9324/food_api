class AddColumnUserIdToProducts < ActiveRecord::Migration[5.0]
  def change
  	add_reference :products, :user, index: true, foreign_key:true
  end
end

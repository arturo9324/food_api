class AddStateToProduct < ActiveRecord::Migration[5.0]
  def change
  	add_column :products, :state, :string, default: "on_hold"
  end
end

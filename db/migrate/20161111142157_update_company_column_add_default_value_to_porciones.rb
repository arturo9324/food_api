class UpdateCompanyColumnAddDefaultValueToPorciones < ActiveRecord::Migration[5.0]
  def change
  	change_column :products, :porciones, :boolean, :default => false
  end
end

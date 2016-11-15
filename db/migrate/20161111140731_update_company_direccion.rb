class UpdateCompanyDireccion < ActiveRecord::Migration[5.0]
  def change
  	rename_column :companies, :direcion, :direccion
  end
end

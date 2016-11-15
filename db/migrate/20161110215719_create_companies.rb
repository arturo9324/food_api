class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.references :user, foreign_key: true
      t.string :direcion
      t.string :telefono
      t.string :nombre

      t.timestamps
    end
  end
end

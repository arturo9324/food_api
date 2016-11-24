class CreateAppUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :app_users do |t|
      t.string :email
      t.string :name
      t.integer :uid
      t.string :provider
      t.date :fecha_nacimiento
      t.float :peso
      t.float :estatura
      t.boolean :sexo, default: true
      t.float :max_calorias
      t.float :min_calorias
      t.boolean :embarazo, default: false
      t.boolean :lactacia, default: false

      t.timestamps
    end
  end
end

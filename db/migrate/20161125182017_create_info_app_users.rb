class CreateInfoAppUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :info_app_users do |t|
      t.references :app_user, foreign_key: true
      t.date :fecha_nacimiento
      t.float :peso
      t.float :estatura
      t.boolean :sexo, default: true
      t.float :max_calorias
      t.float :min_calorias
      t.boolean :embarazo, default: false
      t.boolean :lactancia, default: false

      t.timestamps
    end
  end
end

class CreateAppUserCalory < ActiveRecord::Migration[5.0]
  def change
    create_table :app_user_calories do |t|
      t.references :app_user, foreign_key: true
      t.float :gasto

      t.timestamps
    end
  end
end

class AddFechaToAppUserCalories < ActiveRecord::Migration[5.0]
  def change
    add_column :app_user_calories, :fecha, :date
  end
end

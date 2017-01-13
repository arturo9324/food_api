class RenameColumnMeasureAbrebiacionToAbreviacion < ActiveRecord::Migration[5.0]
  def change
  	rename_column :measures, :abrebiacion, :abreviacion
  end
end

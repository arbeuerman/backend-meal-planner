class CreateMeals < ActiveRecord::Migration[6.1]
  def change
    create_table :meals do |t|
      t.string :typeOfMeal
      t.belongs_to :recipe, null: false, foreign_key: true
      t.string :date

      t.timestamps
    end
  end
end

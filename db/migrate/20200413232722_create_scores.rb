class CreateScores < ActiveRecord::Migration[6.0]
  def change
    create_table :scores do |t|
      t.float :score
      t.references :ramen_store, null: false, foreign_key: true
      t.references :ramen_store_review, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateRamenStoreReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :ramen_store_reviews do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.references :ramen_store, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

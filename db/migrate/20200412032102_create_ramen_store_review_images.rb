class CreateRamenStoreReviewImages < ActiveRecord::Migration[6.0]
  def change
    create_table :ramen_store_review_images do |t|
      t.string :name
      t.string :image
      t.references :ramen_store_review, null: false, foreign_key: true

      t.timestamps
    end
  end
end

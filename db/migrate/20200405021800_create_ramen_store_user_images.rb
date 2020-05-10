class CreateRamenStoreUserImages < ActiveRecord::Migration[6.0]
  def change
    create_table :ramen_store_user_images do |t|
      t.string :name
      t.string :image
      t.boolean :main
      t.references :ramen_store, null: false, foreign_key: true

      t.timestamps
    end
  end
end

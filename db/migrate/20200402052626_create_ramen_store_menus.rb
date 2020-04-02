class CreateRamenStoreMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :ramen_store_menus do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.references :ramen_store, null: false, foreign_key: true

      t.timestamps
    end
  end
end

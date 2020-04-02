class CreateRamenStoreMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :ramen_store_menus do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.integer :ramen_store_id

      t.timestamps
    end
  end
end

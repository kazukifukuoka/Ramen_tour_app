class CreateRamenStores < ActiveRecord::Migration[6.0]
  def change
    create_table :ramen_stores do |t|
      t.string :name, null: false, index: true
      t.text :content, null: false
      t.string :sale, null: false
      t.string :address, null: false
      t.string :sns, null: false
      t.string :phone_number, null: false
      t.string :parking_space, null: false
      t.string :prefecture, null: false, index: true

      t.timestamps
    end
    add_index :ramen_stores, :phone_number, unique: true
  end
end

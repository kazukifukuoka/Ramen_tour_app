class CreateRamenStores < ActiveRecord::Migration[6.0]
  def change
    create_table :ramen_stores do |t|
      t.string :name, null: false, index: true, unique: true
      t.text :content, null: false
      t.text :menu, null: false
      t.string :sale, null: false
      t.string :address, null: false
      t.string :sns, null: false, unique: true
      t.string :phone_number, null: false, unique: true
      t.string :parking_space, null: false
      t.string :prefecture, null: false, index: true

      t.timestamps
    end
  end
end

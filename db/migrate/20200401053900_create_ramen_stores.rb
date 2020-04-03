class CreateRamenStores < ActiveRecord::Migration[6.0]
  def change
    create_table :ramen_stores do |t|
      t.string :name, null: false, index: true
      t.string :postcode, null: false
      t.integer :prefecture_id, null: false, index: true
      t.string :city, null: false
      t.string :address, null: false
      t.string :building
      t.string :phone_number, null: false
      t.string :sale, null: false
      t.string :holiday, null: false
      t.string :seat, null: false
      t.string :access, null: false
      t.string :parking_space, null: false
      t.string :sns, null: false
      t.text :content, null: false

      t.timestamps
    end
    add_index :ramen_stores, :phone_number, unique: true
  end
end

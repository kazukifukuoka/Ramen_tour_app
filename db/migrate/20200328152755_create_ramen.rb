class CreateRamen < ActiveRecord::Migration[6.0]
  def change
    create_table :ramen do |t|
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end

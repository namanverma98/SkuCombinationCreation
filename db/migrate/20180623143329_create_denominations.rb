class CreateDenominations < ActiveRecord::Migration[5.0]
  def change
    create_table :denominations do |t|
      t.string :sku_denomination
      t.text :sku_combination

      t.timestamps
    end
  end
end

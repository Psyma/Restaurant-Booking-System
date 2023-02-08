class CreateProducts < ActiveRecord::Migration[7.0]
    def change
        create_table :products do |t|
            t.string :name
            t.string :cooking_time
            t.string :price
            t.integer :is_available 
            t.integer :order_id

            t.timestamps
        end
    end
end

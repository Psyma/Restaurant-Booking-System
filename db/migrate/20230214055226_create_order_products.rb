class CreateOrderProducts < ActiveRecord::Migration[7.0]
    def change
        create_table :order_products do |t|
            t.integer :product_id
            t.belongs_to :order, index: true, foreign_key: true

            t.timestamps
        end
    end
end

class CreateOrders < ActiveRecord::Migration[7.0]
    def change
        create_table :orders do |t|
            t.string :total_amount
            t.belongs_to :reservation, index: true, foreign_key: true

            t.timestamps
        end
    end
end

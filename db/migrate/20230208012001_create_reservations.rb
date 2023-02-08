class CreateReservations < ActiveRecord::Migration[7.0]
    def change
        create_table :reservations do |t|
        t.string :date
        t.integer :status
        t.integer :user_id

        t.timestamps
        end
    end
end

class CreateReservations < ActiveRecord::Migration[7.0]
    def change
        create_table :reservations do |t|
            t.string :date
            t.integer :status
            t.belongs_to :user, index: true, foreign_key: true

            t.timestamps
        end
    end
end

class CreateMeetupFees < ActiveRecord::Migration
  def change
    create_table :meetup_fees do |t|
      t.string :key
      t.integer :value
      t.integer :quota
      t.belongs_to :meetup, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

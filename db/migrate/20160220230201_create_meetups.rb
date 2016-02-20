class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.string :title
      t.datetime :open_at
      t.datetime :close_at
      t.datetime :deadline
      t.string :place
      t.text :intro
      t.references :author, index: true

      t.timestamps null: false
    end

    add_foreign_key :meetups, :users, column: :author_id
  end
end

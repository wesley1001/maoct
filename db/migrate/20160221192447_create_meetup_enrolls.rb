class CreateMeetupEnrolls < ActiveRecord::Migration
  def change
    create_table :meetup_enrolls do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :meetup, index: true, foreign_key: true
      t.belongs_to :meetup_fee, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

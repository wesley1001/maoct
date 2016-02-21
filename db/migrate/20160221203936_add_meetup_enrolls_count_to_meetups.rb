class AddMeetupEnrollsCountToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :meetup_enrolls_count, :integer, default: 0
  end
end

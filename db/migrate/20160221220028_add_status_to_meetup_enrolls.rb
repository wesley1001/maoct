class AddStatusToMeetupEnrolls < ActiveRecord::Migration
  def change
    add_column :meetup_enrolls, :status, :integer, default: 0
  end
end

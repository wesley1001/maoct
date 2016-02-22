class AddRealValueToMeetupFees < ActiveRecord::Migration
  def change
    add_column :meetup_fees, :real_value, :numeric, precision: 8, scale: 2
    MeetupFee.find_each do |fee|
      fee.real_value = fee.value / 100.0
      fee.save!
    end
  end
end

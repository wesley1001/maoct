class ChangeDefaultValueToMeetupFees < ActiveRecord::Migration
  def change
    change_column_default :meetup_fees, :quota, 0
    change_column_default :meetup_fees, :value, 0
  end
end

class AddQuotaUsedToMeetupFees < ActiveRecord::Migration
  def change
    add_column :meetup_fees, :quota_used, :integer
  end
end

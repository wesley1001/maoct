class MeetupFee < ActiveRecord::Base
  belongs_to :meetup

  def value_show
    self.value / 100.0
  end
end

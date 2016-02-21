class MeetupFee < ActiveRecord::Base
  belongs_to :meetup

  after_initialize :init

  def init
    self.quota_used ||= 0
  end

  def value_show
    self.value / 100.0
  end

  def quota_remained
    self.quota - self.quota_used
  end
end

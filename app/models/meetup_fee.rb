class MeetupFee < ActiveRecord::Base
  belongs_to :meetup

  after_initialize :init
  before_save :normalize_value

  def init
    self.quota_used ||= 0
  end

  def quota_remained
    self.quota - self.quota_used
  end

  private
  def normalize_value
    self.value = self.real_value * 100
  end
end

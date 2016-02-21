class Meetup < ActiveRecord::Base
  belongs_to :author, class_name: "User"

  after_initialize :init

  def init
    self.open_at = Time.now
    self.close_at = Time.now
    self.deadline = Time.now
  end
end

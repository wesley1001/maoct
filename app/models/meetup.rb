class Meetup < ActiveRecord::Base
  belongs_to :author, class_name: "User"

  has_many :meetup_fees
  accepts_nested_attributes_for :meetup_fees, reject_if: :all_blank, allow_destroy: true

  after_initialize :init

  def init
    self.open_at = Time.now
    self.close_at = Time.now
    self.deadline = Time.now
  end
end

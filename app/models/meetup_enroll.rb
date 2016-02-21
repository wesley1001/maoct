class MeetupEnroll < ActiveRecord::Base
  belongs_to :user
  belongs_to :meetup
  belongs_to :meetup_fee
end

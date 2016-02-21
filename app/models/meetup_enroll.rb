class MeetupEnroll < ActiveRecord::Base
  belongs_to :user
  belongs_to :meetup, counter_cache: true
  belongs_to :meetup_fee
end

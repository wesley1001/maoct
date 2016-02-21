class PayController < ApplicationController
  layout "pay"

  def new
    @enroll = MeetupEnroll.find_by_id(request.params[:id])
  end

  def create
  end

  def wx_notify
  end
end

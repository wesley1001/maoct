class MeetupEnrollsController < ApplicationController
  layout 'meetups'

  # before_action :authenticate_user!
  before_action :set_meetup_enroll, only: [:show]
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:create]

  # GET /meetup_enrolls
  def index
    @enrolls = current_user.meetup_enrolls
  end

  # POST /meetup_enrolls
  def create
    @enroll = MeetupEnroll.new(meetup_enroll_params)
    meetup = Meetup.find_by_id(@enroll.meetup_id)
    meetup_fee = MeetupFee.find_by_id(@enroll.meetup_fee_id)
    if meetup && meetup_fee
      if meetup.apply_expired?
        render json: {err: 10001, err_msg: 'apply expired'}
      elsif meetup_fee.quota > 0 && meetup_fee.quota < meetup_fee.quota_used
        render json: {err: 10002, err_msg: 'not enough quota'}
      else
        @enroll.status = 1 if meetup_fee.value == 0
        @enroll.user = current_user
        @enroll.save
      end
    end

    if @enroll.persisted?
      meetup_fee.quota_used += 1
      meetup_fee.save
      render json: {
               err: 0, err_msg: '',
               fee: meetup_fee.value,
               enroll_id: @enroll.id
             }
    end
  end

  def show
  end

  private
  def set_meetup_enroll
    @enroll = current_user.meetup_enrolls.find(params[:id])
  end

  def meetup_enroll_params
    params.require(:meetup_enroll).permit(:meetup_id, :meetup_fee_id)
  end
end

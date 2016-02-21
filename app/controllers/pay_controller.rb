class PayController < ApplicationController
  layout "pay"

  before_action :authenticate_user!

  def new
    enroll = MeetupEnroll.find_by_id(request.params[:id])
    @pay = Pay.new
    @pay.id = enroll.id
    @pay.type = :meetup_enroll
    @pay.key = enroll.meetup_fee.key
    @pay.value = enroll.meetup_fee.value
    @pay.value_show = enroll.meetup_fee.value_show
  end

  def create
    @enroll = MeetupEnroll.find_by_id(request.params[:id])
    params = {
      body: @enroll.meetup_fee.key,
      out_trade_no: "maoct-#{Time.now.to_i}",
      total_fee: @enroll.meetup_fee.value,
      spbill_create_ip: request.remote_ip,
      notify_url: Figaro.env.wechat_pay_notify_url,
      trade_type: 'JSAPI',
      openid: current_user.uid
    }
    prepay_result = WxPay::Service.invoke_unifiedorder(params)
    if prepay_result['return_code'] == 'SUCCESS'
      pay_params = {
        appId: Figaro.env.wechat_app_id,
        timeStamp: Time.now.to_i.to_s,
        nonceStr: SecureRandom.uuid.tr('-', ''),
        package: "prepay_id=#{prepay_result['prepay_id']}",
        signType: 'MD5'
      }
      sign = WxPay::Sign.generate(pay_params)
      render json: pay_params.merge(paySign: sign)
    else
      logger.error "Error: #{prepay_result['return_msg']}"
      render json: prepay_result
    end
  end
end

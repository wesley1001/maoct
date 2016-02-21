class PayController < ApplicationController
  layout "pay"

  before_action :authenticate_user!, except: [:wx_notify]
  skip_before_action :verify_authenticity_token, only: [:wx_notify]

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
      notify_url: "http://m.goofansu.com/notify_pay_result",
      trade_type: 'JSAPI',
      openid: current_user.uid,
      attach: {id: @enroll.id, type: :meetup_enroll}.to_json
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

  def wx_notify
    result = Hash.from_xml(request.body.read)['xml']
    logger.debug result
    if WxPay::Sign.verify?(result)
      render xml: { return_code: 'SUCCESS', return_msg: 'OK' }.to_xml(root: 'xml', dasherize: false)
    else
      render xml: { return_code: 'FAIL', return_msg: 'Signature Error' }.to_xml(root: 'xml', dasherize: false)
    end
  end
end

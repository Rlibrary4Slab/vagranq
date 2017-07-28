class InquiryMailer < ActionMailer::Base
  default from: "ranqmedia@gmail.com"   # 送信元アドレス
  default to: "ranqmedia@gmail.com"     # 送信先アドレス
 
  def received_email(inquiry)
    @inquiry = inquiry
    mail(:subject => 'お問い合わせを承りました')
  end
 
end

class InquiryMailer < ActionMailer::Base
  default from: "example@example.com"   # 送信元アドレス
  default to: "ranqmedia@gmail.com"     # 送信先アドレス
 
  def received_email(inquiry)
    @inquiry = inquiry
    mail(:subject => 'お問い合わせを承りました')
  end
  def received_email_about_article(inquiry)
    @inquiry = inquiry
    mail(:subject => 'お問い合わせを承りました')
  end
  def received_email_about_article_for_user(inquiry)
    @inquiry = inquiry
    mail(:subject => 'お問い合わせを承りました')
  end
 
end

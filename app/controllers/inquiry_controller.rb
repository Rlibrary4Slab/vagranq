class InquiryController < ApplicationController
  def index
    # 入力画面を表示
     
    @inquiry = Inquiry.new
    render :action => 'index'
  end
 
  def confirm
    # 入力値のチェック
    @inquiry = Inquiry.new(params[:inquiry])
    if @inquiry.valid?
      # OK。確認画面を表示
      render :action => 'confirm'
    else
      if @inquiry.article_title.nil?
      # NG。入力画面を再表示
       render :action => 'index'
      else 
       render :template => "articles/article_inquiry"
      end
    end
  end
 
  def thanks
    # メール送信
    @inquiry = Inquiry.new(params[:inquiry])
    if @inquiry.article_title.nil?
     InquiryMailer.received_email(@inquiry).deliver
    else 
     InquiryMailer.received_email_about_article(@inquiry).deliver if @inquiry.type == "20"
     InquiryMailer.received_email_about_article_for_user(@inquiry).deliver if @inquiry.type == "30"
    
    end
     
 
    # 完了画面を表示
    render :action => 'thanks'
  end

end

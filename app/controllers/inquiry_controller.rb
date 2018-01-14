class InquiryController < ApplicationController
  def index
    # 入力画面を表示
     puts REDIS.zrevrange "articles_ranking/daily/#{Date.today.to_s}/#{Time.now.to_time.strftime("%H00").to_s}", 0, -1,withscores: true
     #@articles_ranking = ids.map{ |id| Article.find(id) }
     #Article.find([ids]).each do |article|
     # puts article.id
     #end
     
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

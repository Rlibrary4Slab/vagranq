class Inquiry
  include ActiveModel::Model
 
  attr_accessor :name, :email, :message,:article_title,:article_id,:type,:ipAddress
 
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+.[a-z]+\z/i
  validates :name, :presence => {:message => '名前を入力してください'}
  validates :email, length: {maximum:255},format: {with: VALID_EMAIL_REGEX,message: "メールアドレスを入力してください"}
  #validates :type ,presence: {:message => "お問い合わせ種類を選択してください"}, exclusion: { in: %w(10) ,message: "お問い合わせ種類を選択してください"}
  #enum type: { "お問い合わせ種類を選択してください": 10, "投稿への報告": 20, "投稿を書いたユーザーへの提案": 30 } 
end

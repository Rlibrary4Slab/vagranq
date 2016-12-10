class ArticleForm
  include Virtus

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :title, String
  attribute :description, String
  attribute :address, String

  # validationが必要ならここにvalidatesを書ける
  #  validates :title, presence: true

  def search
    scoped = Article.scoped
    scoped = Article.where("title LIKE ?", "%#{title}%") if title.present?
    scoped = Article.where("description LIKE ?", "%#{description}%") if description.present?
    #scoped = Article.where("address LIKE ?", "%#{address}%") if address.present?
    scoped
  end
end
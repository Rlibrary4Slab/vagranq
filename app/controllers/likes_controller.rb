class LikesController < ApplicationController
   def like
    @article = Article.find(params[:article_id])
    like = current_user.likes.build(article_id: @article.id)
    like.save
  end

  def unlike
    @article = Article.find(params[:article_id])
    like = current_user.likes.find_by(article_id: @article.id)
    like.destroy
  end
end

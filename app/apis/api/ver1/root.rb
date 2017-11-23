module API
  module Ver1
    class Root < Grape::API

      # これでdomain/api/v1でアクセス出来るようになる。
      version 'v1', using: :path
      format :json

      mount API::Ver1::Users
      mount API::Ver1::Likes
      mount API::Ver1::Articles
      mount API::Ver1::Items
      mount API::Ver1::ItemLikes

      # 404NotFoundの扱い
      #route :any, '*path' do
      #  error! I18n.t('grape.errors.not_found'), 404
      #end

    end
  end
end

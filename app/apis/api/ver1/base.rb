module API
  module V1
    class Base < Grape::API
      version 'v1', using: :path
      format :json
      default_format :json

      mount V1::Users
    end
  end
end

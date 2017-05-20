class Content < ActiveRecord::Base
    include ContentSearchable
    belongs_to :article
end

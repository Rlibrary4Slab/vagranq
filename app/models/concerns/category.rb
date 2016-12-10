class Category < ActiveRecord::Base
    belongs_to :article
    acts_as_nested_set
end

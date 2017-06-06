
module ArticleSearchable

  extend ActiveSupport::Concern
  included do
    include Elasticsearch::Model
    # インデックスするフィールドの一覧
    #INDEX_FIELDS = %w(title description contents.description contents.title).freeze
    # インデックス名
    index_name "es_sample_article_#{Rails.env}"
    # マッピング情報
    settings do
      mappings dynamic: 'false' do # 動的にマッピングを生成しない
       
         
        #indexes :contents, type: :nested  do
        indexes :contents do

         indexes :title,analyzer: 'kuromoji', type: 'String'
         indexes :description,analyzer: 'kuromoji', type: 'String'

 	end
       
        indexes :description,  analyzer: 'kuromoji', type: 'String'
        indexes :title,  analyzer: 'kuromoji', type: 'String'
       
	
      end
    end
    # インデックスするデータを生成
    # @return [Hash]
    def as_indexed_json(option = {})
      #self.as_json.select { |k, _| INDEX_FIELDS.include?(k) }
      self.as_json(include: {
          contents:  {only: [:description ,:title] }
      	}
      )
     # attributes
     #  .symbolize_keys
     #  .slice(:title,:description,content: {only: [:description, :title] })
       #.merge(contents: { title: contents.title})
     #{
     #  title: title,
     #  description: description,
     #  include: {
     #  
     #	content: {only: [:description ,:title]}
     #  }
     #}

    end
  end

  #def self.search(params = {})
  #def self.search(params)
    # 検索パラメータを取得
    #keyword = params[:q]

  #  search_definition = Elasticsearch::DSL::Search.search {
  #    filtered{
  #      query {
  #        if keyword.present?
  #          multi_match {
  #	      operator 'and'
  #            #query 'keyword'
  #            #fields %w{contents.description contents.title}
  #          }
  #        else
  #          match_all
  #        end
  #      }
  #    }
  #  }

    # 検索クエリをなげて結果を表示
    # __elasticsearch__にElasticsearchを操作するたくさんのメソッドが定義されている
    #__elasticsearch__.search(search_definition)
  #end


  

  class << self
    def search(query)
      __elasticsearch__.search({
        query: {
          multi_match: {
            fields: %w(title description contents.title contents.description),
            fuzziness: "AUTO",
            query: query
          }
        }
      })
    end

  end
 
  def more_like_this
   self.class.__elasticsearch__.search({
    query: {
      more_like_this: {
        fields: %w(title description contents.title contents.description),
        ids: [id],
        min_doc_freq: 0,
        min_term_freq: 0
      }
     }
   })   
 
  end   
 
 module  ClassMethods
    # indexの作成メソッド
    def create_index!
      client = __elasticsearch__.client
      client.indices.delete index: self.index_name rescue nil
      client.indices.create(index: self.index_name,
                            body: {
                                settings: self.settings.to_hash,
                                mappings: self.mappings.to_hash
                            })
    end
  end
end

class Book
    #モデル機能(ActiveModel::Model)をいれる。
    #メリット
    #validationが使える。
    #モデルオブジェクトとして認識されるのでform_forが使える。
    #翻訳　おそらくvalidationエラーの
    #モデル名の調査
    
    include ActiveModel::Model
    
     attr_accessor :title, :image_url, :url #ゲッター、セッターをセット
     
     #validates :name, presence: true
     
     def initialize(title, image_url, url)
    
        @title = title
        @image_url = image_url
        @url = url
    
     end
    
end
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
    
    validates :name, presence: true
    validates :gender, presence: true, on: :update
    
    
    def self.find_for_oauth(auth)

      #fasebookのみで
      user = User.where(uid: auth.uid, provider: auth.provider).first
      

      unless user
        
        user = User.create(
          uid: auth.uid,
          provider: auth.provider,
          name: auth.info.name,
          email: auth.info.email,
          password: Devise.friendly_token[0, 20]
          #パスワードはDevise.friendly_token[0, 20]により生成され、そのパスワードはランダムに決まった数字20桁の為、登録したユーザはわからず
                    )
      end
      
      return user
    end
end

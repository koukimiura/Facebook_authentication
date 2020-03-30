class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
    
    validates :name, presence: true
    validates :gender, presence: true
    
    
    def self.find_for_oauth(auth)
      logger.debug("-----------auth=#{auth}")
      
      #fasebookのみで
      user = User.where(uid: auth.uid, provider: auth.provider).first
      

      unless user
        case auth.extra.raw_info.gender
          when "male" then
            g = 1
          when "female" then
            g = 2
        end
        
        logger.debug("--------------email=#{auth.info.email}")
        logger.debug("--------------auth.info.name=#{auth.info.name}")
        logger.debug("--------------gender =#{auth.extra.raw_info.gender}")
        logger.debug("--------------uid=#{auth.uid}")
        user = User.create(
          uid: auth.uid,
          provider: auth.provider,
          name: auth.info.name,
          gender: g,
          email: auth.info.email,
          password: Devise.friendly_token[0, 20]
          #パスワードはDevise.friendly_token[0, 20]により生成され、そのパスワードはランダムに決まった数字20桁の為、登録したユーザはわからず
                    )
      end
      
      return user
    end
end

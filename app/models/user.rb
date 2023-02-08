class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable,
            :omniauthable, omniauth_providers: [:google_oauth2, :facebook, :linkedin, :twitter2]

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :address, presence: true
    
    def self.from_omniauth(auth)  
        Rails.logger.info(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|  
            user.email = auth.info.email
            user.password = Devise.friendly_token[0, 20]
            user.first_name = "0"
            user.last_name = "0"
            user.full_name = auth.info.name
            user.address = "0"
            if auth.provider == "linkedin" 
                user.first_name = auth.info.first_name
                user.last_name = auth.info.last_name
                user.avatar_url = auth.info.picture_url
            elsif auth.provider == "google_oauth2" 
                user.first_name = auth.info.first_name
                user.last_name = auth.info.last_name
                user.avatar_url = auth.info.image  
            elsif auth.provider == "facebook"
                user.avatar_url = auth.info.image
            elsif auth.provider == "twitter2"
                user.avatar_url = auth.info.image
            end
            user.role = Roles::CUSTOMER 
        end 
    end 
end

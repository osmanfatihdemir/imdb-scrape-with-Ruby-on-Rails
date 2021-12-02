# email:string
# password_digest:string
# 
# password:string virtutal
# password_confirmation:string virtual
class User < ApplicationRecord
    has_secure_password
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
    #validates :email, presence :true, format:{with:/\A[^@\s]+@[^@\s]+\z/, message:"must be a invalid email adress"}
end

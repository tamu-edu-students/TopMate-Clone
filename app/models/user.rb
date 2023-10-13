class User < ApplicationRecord
    has_secure_password
    has_many :hours
    has_many :services
end

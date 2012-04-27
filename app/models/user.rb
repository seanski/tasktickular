class User < ActiveRecord::Base
  attr_accessible :email, :username
  has_many :authorizations
end

class Authorization < ActiveRecord::Base
  attr_accessible :email, :first_name, :image, :last_name, :location, :name, :nickname, :provider, :secret, :token, :uid, :user_id

  belongs_to :user
end

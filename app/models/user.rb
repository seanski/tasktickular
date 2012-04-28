class User < ActiveRecord::Base
  attr_accessible :email, :username
  has_many :authorizations

  def has_valid_authorizations?
    authorizations.count > 0
  end
end

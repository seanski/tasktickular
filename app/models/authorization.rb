class Authorization < ActiveRecord::Base
  attr_accessible :email, :first_name, :image, :last_name, :location, :name, :nickname, :provider, :secret, :token, :uid, :user_id

  belongs_to :user
  scope :with_user, includes(:user)
  scope :provider, ->(provider) { where(provider: provider) }
  scope :credentials, ->(provider, uid) { provider(provider).where(uid: uid.to_s) }

  def registration_dump
    self.as_json(include: :user)
  end

  class << self
    def find_or_create_from_auth_hash(auth_hash, user)
      auth = Authorization.credentials(auth_hash['provider'], auth_hash['uid']).with_user.first
      if auth
        auth.token = auth_hash['credentials']['token']
        auth.save
        auth
      else
        create_user_and_auth(auth_hash, user)
      end
    end

    def create_user_and_auth(auth_hash, user)
      info = auth_hash['info']
      name = info['nickname'] || info['name']
      email = info['email']
      credentials = auth_hash['credentials']
      user = User.create(username: name, email: email) if user.nil?
      auth = user.authorizations.create(email: email,
                                        first_name: info['first_name'],
                                        last_name: info['last_name'],
                                        location: info['location'],
                                        provider: auth_hash['provider'],
                                        token: credentials['token'],
                                        uid: auth_hash['uid']
                                        )
    end
  end
end

class AuthenticationError < Exception
  def initialize(message = "You are not logged in.")
    super(message)
  end
end
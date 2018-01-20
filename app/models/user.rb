class User < ApplicationRecord

  def self.sign_in_from_omniauth(auth)
    find_by(name: auth['name'], email: auth['email']) || create_user_from_omniauth(auth)
  end

  def self.create_user_from_omniauth(auth)
    create(
        name: auth['info']['name'],
        email: auth['info']['email'],
        token: auth['credentials']['token']
    )
  end


end

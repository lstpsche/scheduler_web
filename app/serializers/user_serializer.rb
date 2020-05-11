# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :first_name, :last_name, :username, :language_code, :tg_avatar_url, :admin
end

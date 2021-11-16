class SessionSerializer < ApplicationSerializer
  attribute :user do |object, _params|
    {
      id: object.id,
      email: object.email,
      username: object.username,
      role: object.role,
      created_at: object.created_at.strftime("%d/%m/%Y"),
      updated_at: object.updated_at.strftime("%d/%m/%Y")
    }
  end

  attribute :token do |object, params|
    token = params[:token]
    {
      uid: object.uid,
      token: token.token,
      client: token.client,
      expiry: token.expiry
    }
  end
end

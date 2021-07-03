class CompanyAdminSerializer < ApplicationSerializer
  attribute :user do |object, params|
    is_daihyo = params[:is_daihyo]
    {
      id: object.id,
      email: object.email,
      first_name: object.first_name,
      last_name: object.last_name,
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
      client_id: token.client,
      expiry: token.expiry
    }
  end
end
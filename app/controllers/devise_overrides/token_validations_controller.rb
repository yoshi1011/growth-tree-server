module DeviseOverrides
  class TokenValidationsController < DeviseTokenAuth::TokenValidationsController
    protected

    def render_validate_token_success
      render 'devise_overrides/sessions'
    end
  end
end

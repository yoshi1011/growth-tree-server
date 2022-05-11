module DeviseOverrides
  class SessionsController < DeviseTokenAuth::SessionsController

    protected

    def render_create_success
      render 'devise_overrides/sessions'
    end
  end
end

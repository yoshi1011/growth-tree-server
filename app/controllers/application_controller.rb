class ApplicationController < ActionController::API
        include ActionController::Cookies
        include DeviseTokenAuth::Concerns::SetUserByToken
end

class ApplicationController < ActionController::Base
  protect_from_forgery

  def parse_signed_request
    @oauth ||= Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, APP_URL)
    if params[:signed_request]
      @@parse_signed_request = @oauth.parse_signed_request(params[:signed_request])
    else
      @@parse_signed_request = false
    end

    # If you've setup a configuration file as shown above then you can just do
    # @facebook_cookies ||= Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
  end

end

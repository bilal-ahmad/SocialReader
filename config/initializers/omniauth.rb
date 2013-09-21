if Rails.env.production?
  ENV['FB_APP_ID']= APP_ID = '121516724724133'
  ENV['FB_SECRET_KEY'] = APP_SECRET = '2ca4a51c343e1cafc1c8f67fd6d3a0d5'
  Authentication_URL = 'http://socialtribune.herokuapp.com/auth/facebook'
  APP_URL = 'http://socialtribune.herokuapp.com/'
  FB_Canvas_URL = 'http://apps.facebook.com/socialtribune'
elsif Rails.env.development?
  ENV['FB_APP_ID'] = APP_ID = '102978613227566'
  ENV['FB_SECRET_KEY']= APP_SECRET = '9ddc1d051ebec38708661b152867ae57'
  Authentication_URL = 'http://localhost:3000/auth/facebook'
  APP_URL = 'http://localhost:3000'
  FB_Canvas_URL = 'http://apps.facebook.com/social-reader-local/'
end

# config/initializers/koala.rb
# Simple approach
Koala::Facebook::OAuth.class_eval do
  def initialize_with_default_settings(*args)
    raise 'application id and/or secret are not specified in the envrionment' unless ENV['FB_APP_ID'] && ENV['FB_SECRET_KEY']
    initialize_without_default_settings(ENV['FB_APP_ID'].to_s, ENV['FB_SECRET_KEY'].to_s, args.first)
  end

  alias_method_chain :initialize, :default_settings
end


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FB_APP_ID'], ENV['FB_SECRET_KEY'], :scope => 'email, publish_actions'
end
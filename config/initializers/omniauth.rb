Rails.application.config.middleware.use OmniAuth::Builder do
  #Uncomment these as you enable them
  #provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  #provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'], { access_type: "offline", approval_prompt: "" }
  #provider :facebook, ENV['FACEBOOK_ID'], ENV['FACEBOOK_SECRET']
end
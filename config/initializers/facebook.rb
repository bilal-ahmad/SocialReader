#if Rails.env.production?
#  APP_ID = "422590194429416"
#  APP_SECRET = "a2139ebdc5bd58dab5b4e460297549f9"
#  Authentication_URL = "http://sr-beta.herokuapp.com/auth/facebook"
#  APP_URL = "http://sr-beta.herokuapp.com"
#  FB_Canvas_URL = "https://apps.facebook.com/sr-beta/"
#elsif Rails.env.development?
#  APP_ID = "102978613227566"
#  APP_SECRET = "9ddc1d051ebec38708661b152867ae57"
#  Authentication_URL = "http://localhost:3000auth/facebook"
#  APP_URL = "http://localhost:3000"
#  FB_Canvas_URL = "https://apps.facebook.com/social-reader-local/"
#end
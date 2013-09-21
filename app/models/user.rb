class User < ActiveRecord::Base
  attr_accessible :email, :fb_id, :first_name, :image, :last_name, :name, :sharing, :status, :token
end

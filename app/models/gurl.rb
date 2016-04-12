class Gurl < ActiveRecord::Base
  
  DOMAIN = "localhost:3000".freeze

  def gatorly_url
    "#{ENV[DOMAIN]}/#{gatorly}"
  end
end

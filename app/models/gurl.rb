class Gurl < ActiveRecord::Base
  def gatorly_url
    "#{ENV['DOMAIN']}/#{gatorly}"
  end
end

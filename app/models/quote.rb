class Quote < ActiveRecord::Base
  def dash_author
    "-#{author}" unless author.blank?
  end
end

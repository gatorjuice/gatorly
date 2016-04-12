class AddGatorlyToGurls < ActiveRecord::Migration
  def change
    add_column :gurls, :gatorly, :string
  end
end

class CreateGurls < ActiveRecord::Migration
  def change
    create_table :gurls do |t|
      t.string :dest

      t.timestamps null: false
    end
  end
end

class CreateBuildingsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :buildings do |t|
      t.string :address
      t.float :latitude, null: false, default: 0.0
      t.float :longitude, null: false, default: 0.0
    end
  end
end

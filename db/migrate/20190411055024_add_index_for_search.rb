class AddIndexForSearch < ActiveRecord::Migration[5.1]
  def up
    execute "CREATE INDEX ON buildings USING gist (ll_to_earth(latitude, longitude));"
  end

  def down
  end
end

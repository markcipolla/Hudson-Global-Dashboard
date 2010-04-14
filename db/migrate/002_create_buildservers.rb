class CreateBuildservers < ActiveRecord::Migration
  def self.up
    create_table :buildservers do |t|
      t.string :address
      t.text :description
    end
  end

  def self.down
    drop_table :buildservers
  end
end

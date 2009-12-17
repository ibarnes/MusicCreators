class CreateScore < ActiveRecord::Migration
  def self.up
    create_table :scores do |t|
      t.integer    :user_id
      t.integer    :score
      t.timestamp
    end
  end

  def self.down
     drop_table  :score
  end
end

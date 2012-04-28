class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :summary
      t.string :origin
      t.datetime :did_at
      t.integer :time_spent_in_minutes
      t.references :user

      t.timestamps
    end
    add_index :activities, :user_id
  end
end

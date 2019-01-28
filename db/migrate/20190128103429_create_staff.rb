class CreateStaff < ActiveRecord::Migration[5.2]
  def change
    create_table :staff do |t|
      t.string :staff_id
      t.string :working_pattern
      t.string :status

      t.timestamps
    end
  end
end

class CreateAllocations < ActiveRecord::Migration[5.2]
  def change
    create_table :allocations do |t|
      t.index :offender_no
      t.string :offender_id
      t.string :prison
      t.string :allocated_at_tier
      t.string :reason
      t.string :note
      t.string :created_by
      t.boolean :active
      t.references :staff, foreign_key: true

      t.timestamps
    end
  end
end

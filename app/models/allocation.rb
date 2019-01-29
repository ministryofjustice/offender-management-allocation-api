class Allocation < ApplicationRecord
  belongs_to :staff, class_name: 'Staff'

  validates :offender_no, :offender_id, :prison, :allocated_at_tier,
    :created_by, :active, presence: true
end

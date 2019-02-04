class Allocation < ApplicationRecord
  belongs_to :prison_offender_manager

  validates :offender_no, :offender_id, :prison, :allocated_at_tier,
    :created_by, presence: true
end

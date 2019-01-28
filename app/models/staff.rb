class Staff < ApplicationRecord
  self.table_name = 'staff'
  has_many :allocations, dependent: :destroy

  validates :staff_id, :working_pattern, :status, presence: true
end

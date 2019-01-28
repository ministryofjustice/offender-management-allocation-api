require 'rails_helper'

RSpec.describe Allocation, type: :model do
  it { is_expected.to belong_to(:staff) }
  it { is_expected.to validate_presence_of(:offender_no) }
  it { is_expected.to validate_presence_of(:offender_id) }
  it { is_expected.to validate_presence_of(:prison) }
  it { is_expected.to validate_presence_of(:allocated_at_tier) }
  it { is_expected.to validate_presence_of(:reason) }
  it { is_expected.to validate_presence_of(:note) }
  it { is_expected.to validate_presence_of(:created_by) }
  it { is_expected.to validate_presence_of(:active) }
end

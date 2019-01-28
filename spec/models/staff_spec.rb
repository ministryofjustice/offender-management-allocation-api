require 'rails_helper'

RSpec.describe Staff, type: :model do
  it { is_expected.to validate_presence_of(:staff_id) }
  it { is_expected.to validate_presence_of(:working_pattern) }
  it { is_expected.to validate_presence_of(:status) }
end

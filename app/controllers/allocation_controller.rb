class AllocationController < ApplicationController
  before_action :authorise

  def create
    AllocationService.create_allocation(allocation_params)
    render_ok
  end

private

  def allocation_params
    params.require(:allocation).permit(
      :nomis_staff_id, :offender_no, :offender_id, :allocated_at_tier,
      :created_by, :prison, :override_reason, :note, :email
    )
  end
end

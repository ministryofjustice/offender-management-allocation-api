class PomsController < ApplicationController
  before_action :authorise

  def show
    staff_ids = params.require(:ids).gsub(/[^\d]/, '').split('')
    response = StaffService.get_poms(staff_ids)

    render(
      json: {
        'poms' => response.as_json(include: [:allocations])
      }
    )
  end
end

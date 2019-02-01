class PomsController < ApplicationController
  before_action :authorise

  def show
    staff_ids = params[:ids].split(',')
    response = StaffService.get_poms(staff_ids)

    render(
      json: {
        'poms' => response
      }
    )
  end
end

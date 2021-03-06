class PomsController < ApplicationController
  before_action :authorise

  def show
    nomis_staff_ids = params.require(:ids).gsub(/[^\d]/, '').split('')
    response = PrisonOffenderManagerService.get_poms(nomis_staff_ids)
    data = response.as_json(include: [:allocations])

    render_ok(data)
  end
end

class ApplicationController < ActionController::API
  include Authorisable

  rescue_from ActiveRecord::RecordInvalid do |e|
    render_error(e.to_s)
  end

  def render_ok
    render(
      json: {
        'status' => 'ok',
        'errorMessage' => ''
      }
    )
  end

  def render_error(msg)
    render(
      json: {
        'status' => 'error',
        'errorMessage' => msg
      }
    )
  end
end

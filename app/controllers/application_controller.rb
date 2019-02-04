class ApplicationController < ActionController::API
  include Authorisable

  rescue_from ActiveRecord::RecordInvalid do
    render_error
  end

  def render_ok
    render(
      json: {
        'status' => 'ok',
        'errorMessage' => ''
      }
    )
  end

  def render_error
    render(
      json: {
        'status' => 'error',
        'errorMessage' => 'Invalid request'
      }
    )
  end
end

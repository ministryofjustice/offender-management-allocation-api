class StatusController < ApplicationController
  def index
    postgres_version = ActiveRecord::Base.connection.select_value('SELECT version()')

    render(json: { 
      'status' => 'ok',
      'postgresVersion' => postgres_version
    })
  end
end

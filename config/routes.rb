Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  get('/poms/:ids' => 'poms#show')

  get('status' => 'status#index')
  get('health' => 'health#index')

  post('allocation' => 'allocation#create')
  get('allocation/active' => 'allocation#active')
  post('allocation/active' => 'allocation#active')
end

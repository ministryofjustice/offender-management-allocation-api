Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  get('status' => 'status#index')
  get('health' => 'health#index')

  post('allocation' => 'allocation#create')
end

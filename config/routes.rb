Rails.application.routes.draw do
  get('status' => 'status#index')
  get('health' => 'health#index')
end

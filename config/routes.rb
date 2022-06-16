Rails.application.routes.draw do
  resources :loans, defaults: { format: :json } do
    member do
      resources :payments, param: :payment_id, only: %i[index show create]
    end
  end
end

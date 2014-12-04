require "monban/constraints/signed_in"
require "monban/constraints/signed_out"

Rails.application.routes.draw do

  get 'pages/about' => 'high_voltage/pages#show', id: 'about'
  get 'pages/contact' => 'high_voltage/pages#show', id: 'contact'
  resource :search, only: [:show]
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :update] do
    resources :videos, only: [:new, :create]
  end
  root "dashboards#show"

end

require "monban/constraints/signed_in"
require "monban/constraints/signed_out"

Rails.application.routes.draw do


  get 'pages/home' => 'high_voltage/pages#show', id: 'home'
  get 'pages/about' => 'high_voltage/pages#show', id: 'about'
  get 'pages/contact' => 'high_voltage/pages#show', id: 'contact'
  get 'pages/signup' => 'high_voltage/pages#show', id: 'new_user'
  get 'pages/login' => 'high_voltage/pages#show', id: 'new_session'
  get 'pages/home' => 'high_voltage/pages#show', id: 'home'
  #get 'pages/home' => 'high_voltage/pages#show', id: 'home'


end

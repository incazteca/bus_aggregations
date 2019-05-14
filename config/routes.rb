# frozen_string_literal: true

Rails.application.routes.draw do
  root 'average_bus_stop_boardings#index'
  resources :average_bus_stop_boardings
end

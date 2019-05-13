# frozen_string_literal: true

Rails.application.routes.draw do
  root 'average_bus_stop_boardings#indexj'
  resources :average_bus_stop_boardings
end

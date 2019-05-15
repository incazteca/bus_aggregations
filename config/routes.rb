# frozen_string_literal: true

Rails.application.routes.draw do
  root 'average_bus_stop_boardings#index'
  resources :average_bus_stop_boardings, only: %i[index]

  get(
    'average_bus_stop_boardings/route_aggregation',
    to: 'average_bus_stop_boardings#route_aggregation',
    as: 'route_aggregation'
  )
end

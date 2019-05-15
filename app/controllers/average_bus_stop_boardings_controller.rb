# frozen_string_literal: true

class AverageBusStopBoardingsController < ApplicationController
  AGGREGATION_FUNCTIONS = %w[count sum average minimum maximum].freeze
  AGGREGATION_FIELDS = %w[boardings alightings].freeze

  def index
    @fields_for_routes = AGGREGATION_FIELDS
    @aggregation_functions = AGGREGATION_FUNCTIONS
  end

  def route_aggregation
    aggr_func = params[:aggregate_function] || AGGREGATION_FUNCTIONS.first
    field = params[:aggregate_field] || AGGREGATION_FIELDS.first

    Rails.logger.debug('harp')

    render json: AverageBusStopBoarding.route_aggregates(aggr_func, field)
  end

  private

  def route_aggregation_params
    params.permit(:aggregate_function, :aggregate_field)
  end
end

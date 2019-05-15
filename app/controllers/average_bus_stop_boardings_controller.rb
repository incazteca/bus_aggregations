# frozen_string_literal: true

class AverageBusStopBoardingsController < ApplicationController
  AGGREGATION_FUNCTIONS = %w[count sum average minimum maximum].freeze
  AGGREGATION_FIELDS = %w[boardings alightings].freeze
  GROUP_ON_FIELDS = %w[routes intersection].freeze

  def index
    @fields_for_routes = AGGREGATION_FIELDS
    @aggregation_functions = AGGREGATION_FUNCTIONS
    @group_on_fields = GROUP_ON_FIELDS
  end

  def route_aggregation
    aggr_func = params[:aggregate_function] || AGGREGATION_FUNCTIONS.first
    field = params[:aggregate_field] || AGGREGATION_FIELDS.first
    group_on = params[:group_on_field] || GROUP_ON_FIELDS.first

    render json: AverageBusStopBoarding.route_aggregates(
      aggr_func, field, group_on
    )
  end

  private

  def route_aggregation_params
    params.permit(:aggregate_function, :aggregate_field, :group_on_field)
  end
end

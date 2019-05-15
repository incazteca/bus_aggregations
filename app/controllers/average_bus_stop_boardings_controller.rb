# frozen_string_literal: true

class AverageBusStopBoardingsController < ApplicationController
  def index
    @fields_for_routes = AverageBusStopBoarding::AGGREGATION_FIELDS
    @aggregation_functions = AverageBusStopBoarding::AGGREGATION_FUNCTIONS
    @group_on_fields = AverageBusStopBoarding::GROUP_ON_FIELDS
  end

  def route_aggregation
    aggr_func = params[:aggregate_function] || AverageBusStopBoarding::AGGREGATION_FUNCTIONS.first
    field = params[:aggregate_field] || AverageBusStopBoarding::AGGREGATION_FIELDS.first
    group_on = params[:group_on_field] || AverageBusStopBoarding::GROUP_ON_FIELDS.first
    offset = params[:offset] || 0
    limit = params[:limit] || 20

    render json: AverageBusStopBoarding.route_aggregates(
      aggr_func, field, group_on
    )&.slice(offset..offset + limit)
  end

  private

  def route_aggregation_params
    params.permit(:aggregate_function, :aggregate_field, :group_on_field)
  end
end

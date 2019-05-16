# frozen_string_literal: true

class AverageBusStopBoardingsController < ApplicationController
  def index
    @aggregate_fields = AverageBusStopBoarding::AGGREGATION_FIELDS.map(&:to_s)
    @aggregate_functions = AverageBusStopBoarding::AGGREGATION_FUNCTIONS.map(&:to_s)
    @aggregate_groups = AverageBusStopBoarding::GROUP_ON_FIELDS.map(&:to_s)
    @aggregate_limits = [20, 50, 100]

    @default_params = {
      aggregate: {
        field: @aggregate_fields.first,
        function: @aggregate_functions.first,
        group: @aggregate_groups.first,
        limit: @aggregate_limits.first,
        offset: 0
      }
    }
  end

  def aggregation
    offset = route_aggregation_params[:offset].to_i
    limit = route_aggregation_params[:limit].to_i
    offset = offset.blank? || offset.negative? ? 0 : offset

    render json: AverageBusStopBoarding.aggregate(
      route_aggregation_params[:function] || 0,
      route_aggregation_params[:field] || 0,
      route_aggregation_params[:group] || 0
    )&.slice(offset..(offset + limit))
  end

  private

  def route_aggregation_params
    params
      .require(:aggregate)
      .permit(:field, :function, :group, :limit, :offset)
  end
end

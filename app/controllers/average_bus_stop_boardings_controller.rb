class AverageBusStopBoardingsController < ApplicationController
  def index
    @default_y = 'Boardings'
    @fields_for_routes = %w[boardings alightings]
  end

  def route_aggregation
    aggr_func = params[:aggregate_function] || :count
    field = params[:field] || :boardings

    render json: AverageBusStopBoarding.route_aggregates(aggr_func, field)
  end

  private

  def route_aggregation_params
    params.permit(:aggregate_function, :field)
  end
end

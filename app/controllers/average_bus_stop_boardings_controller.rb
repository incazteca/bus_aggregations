class AverageBusStopBoardingsController < ApplicationController
  def index
    @numeric_columns = AverageBusStopBoarding.columns.map(&:name)
    @bus_stops = AverageBusStopBoarding
    @route_aggregation = AverageBusStopBoarding.route_aggregates(
      params[:aggregate_function], params[:field]
    )
  end

  def route_aggregation
    AverageBusStopBoarding.route_aggregates
  end

  private

  def route_aggregation_params
    params.permit(:aggregate_function, :field)
  end
end

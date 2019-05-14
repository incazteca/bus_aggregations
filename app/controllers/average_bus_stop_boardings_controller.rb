class AverageBusStopBoardingsController < ApplicationController
  def index
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

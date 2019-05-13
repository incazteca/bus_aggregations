class AverageBusStopBoardingsController < ApplicationController
  def index
    @bus_stops = AverageBusStopBoarding
  end
end

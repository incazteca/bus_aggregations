# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'aggregates record' do |aggregate_function, aggregate_field, group_on_field, expected|
  context "SELECT #{aggregate_function}(#{aggregate_field})"\
          " FROM average_bus_stop_boarding GROUP BY #{group_on_field}" do

    subject do
      AverageBusStopBoarding.aggregate(
        aggregate_function, aggregate_field, group_on_field
      )
    end
    it { is_expected.to eq expected }
  end
end

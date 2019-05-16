# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'aggregates record' do |aggregate_function, aggregate_field, group_on_field, expected|
	context "Get the #{aggregate_function} of #{aggregate_field}, Group On #{group_on_field}" do
  	subject { AverageBusStopBoarding.aggregate(aggregate_function, aggregate_field, group_on_field) }
    it { is_expected.to eq expected }
  end
end

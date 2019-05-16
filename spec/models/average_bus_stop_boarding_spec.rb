# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_aggregation'

RSpec.describe AverageBusStopBoarding, type: :model do
  it { is_expected.to validate_numericality_of :boardings }
  it { is_expected.to validate_numericality_of :alightings }
  it { is_expected.to validate_numericality_of :longitude }
  it { is_expected.to validate_numericality_of :latitude }

  it { is_expected.to validate_presence_of :on_street }
  it { is_expected.to validate_presence_of :cross_street }
  it { is_expected.to validate_presence_of :intersection }
  it { is_expected.to validate_presence_of :routes }
  it { is_expected.to validate_presence_of :boardings }
  it { is_expected.to validate_presence_of :alightings }
  it { is_expected.to validate_presence_of :month_beginning }
  it { is_expected.to validate_presence_of :daytype }
  it { is_expected.to validate_presence_of :longitude }
  it { is_expected.to validate_presence_of :latitude }

  # rubocop:disable  Metrics/BlockLength, Metrics/LineLength
  describe '.aggregate' do
    before do
      create(:addison_route, cross_street: 'HARLEM', boardings: 40, alightings: 5)
      create(:addison_route, cross_street: 'OAK PARK', boardings: 30, alightings: 10)
      create(:addison_route, cross_street: 'NORMANDY', boardings: 20, alightings: 15)
      create(:addison_route, cross_street: 'NEENAH', boardings: 10, alightings: 20)

      create(:harlem_route, cross_street: 'ADDISON', boardings: 60, alightings: 30)
      create(:harlem_route, cross_street: 'IRVING PARK', boardings: 20, alightings: 10)
    end

    it_behaves_like 'aggregates record', :count, :boardings, :routes, [['152', 4], ['90', 2]]
    it_behaves_like 'aggregates record', :count, :alightings, :routes, [['152', 4], ['90', 2]]
    it_behaves_like 'aggregates record', :count, :boardings, :intersection, [
      ['ADDISON & HARLEM', 2],
      ['ADDISON & NEENAH', 1],
      ['ADDISON & NORMANDY', 1],
      ['ADDISON & OAK PARK', 1],
      ['HARLEM & IRVING PARK', 1]
    ]
    it_behaves_like 'aggregates record', :count, :alightings, :intersection, [
      ['ADDISON & HARLEM', 2],
      ['ADDISON & NEENAH', 1],
      ['ADDISON & NORMANDY', 1],
      ['ADDISON & OAK PARK', 1],
      ['HARLEM & IRVING PARK', 1]
    ]

    it_behaves_like 'aggregates record', :sum, :boardings, :routes, [['152', 100], ['90', 80]]
    it_behaves_like 'aggregates record', :sum, :alightings, :routes, [['152', 50], ['90', 40]]
    it_behaves_like 'aggregates record', :sum, :boardings, :intersection, [
      ['ADDISON & HARLEM', 100],
      ['ADDISON & OAK PARK', 30],
      ['ADDISON & NORMANDY', 20],
      ['HARLEM & IRVING PARK', 20],
      ['ADDISON & NEENAH', 10]
    ]
    it_behaves_like 'aggregates record', :sum, :alightings, :intersection, [
      ['ADDISON & HARLEM', 35],
      ['ADDISON & NEENAH', 20],
      ['ADDISON & NORMANDY', 15],
      ['ADDISON & OAK PARK', 10],
      ['HARLEM & IRVING PARK', 10]
    ]

    it_behaves_like 'aggregates record', :average, :boardings, :routes, [['90', 40], ['152', 25]]
    it_behaves_like 'aggregates record', :average, :alightings, :routes, [['90', 20], ['152', 12.5]]
    it_behaves_like 'aggregates record', :average, :boardings, :intersection, [
      ['ADDISON & HARLEM', 50],
      ['ADDISON & OAK PARK', 30],
      ['ADDISON & NORMANDY', 20],
      ['HARLEM & IRVING PARK', 20],
      ['ADDISON & NEENAH', 10]
    ]
    it_behaves_like 'aggregates record', :average, :alightings, :intersection, [
      ['ADDISON & NEENAH', 20],
      ['ADDISON & HARLEM', 17.5],
      ['ADDISON & NORMANDY', 15],
      ['ADDISON & OAK PARK', 10],
      ['HARLEM & IRVING PARK', 10]
    ]
  end
  # rubocop:enable Metrics/BlockLength, Metrics/LineLength
end

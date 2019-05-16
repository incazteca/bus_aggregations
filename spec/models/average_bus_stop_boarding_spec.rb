require 'rails_helper'

RSpec.describe AverageBusStopBoarding, type: :model do
  it { is_expected.to validate_numericality_of :routes }
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

  describe '.route_aggregates' do
    before do
      create(:addison_route, cross_street: 'HARLEM', boardings: 40, alightings: 5)
      create(:addison_route, cross_street: 'OAK PARK', boardings: 30, alightings: 10)
      create(:addison_route, cross_street: 'NORMANDY', boardings: 20, alightings: 15)
      create(:addison_route, cross_street: 'NEENAH', boardings: 10, alightings: 20)

      create(:harlem_route, cross_street: 'ADDISON', boardings: 75, alightings: 20)
      create(:harlem_route, cross_street: 'IRVING PARK', boardings: 25, alightings: 30)
    end
  end
end

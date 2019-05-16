require 'rails_helper'

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
end

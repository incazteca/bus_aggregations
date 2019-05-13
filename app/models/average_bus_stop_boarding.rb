# frozen_string_literal: true

class AverageBusStopBoarding < ApplicationRecord
  validates :on_street, presence: true
  validates :cross_street, presence: true
  validates :routes, presence: true, numericality: true
  validates :boardings, presence: true, numericality: true
  validates :alightings, presence: true, numericality: true
  validates :month_beginning, presence: true
  validates :daytype, presence: true
  validates :longitude, presence: true, numericality: true
  validates :latitude, presence: true, numericality: true
end

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

  VALID_AGGREGATES = %i[count sum average minimum maximum].freeze

  def self.route_aggregates(aggregate_function, field, group_on)
    return if aggregate_function.nil? || field.nil? || group_on.nil?

    aggregate = aggregate_function.to_sym
    col = field.to_sym
    group_field = group_on.to_sym

    return unless VALID_AGGREGATES.include? aggregate
    return unless columns.map { |column| column.name.to_sym }.include? col

    group(group_field).calculate(aggregate, col)
  end
end

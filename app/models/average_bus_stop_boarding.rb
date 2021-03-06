# frozen_string_literal: true

class AverageBusStopBoarding < ApplicationRecord
  validates :on_street, presence: true
  validates :cross_street, presence: true
  validates :intersection, presence: true
  validates :routes, presence: true
  validates :boardings, presence: true, numericality: true
  validates :alightings, presence: true, numericality: true
  validates :month_beginning, presence: true
  validates :daytype, presence: true
  validates :longitude, presence: true, numericality: true
  validates :latitude, presence: true, numericality: true

  AGGREGATION_FUNCTIONS = %i[count sum average minimum maximum].freeze
  AGGREGATION_FIELDS = %i[boardings alightings].freeze
  GROUP_ON_FIELDS = %i[routes intersection].freeze

  def self.aggregate(aggregate_function, field, group_on)
    return if aggregate_function.nil? || field.nil? || group_on.nil?

    aggregate = aggregate_function.to_sym
    col = field.to_sym
    group_field = group_on.to_sym

    return unless AGGREGATION_FUNCTIONS.include? aggregate
    return unless AGGREGATION_FIELDS.include? col
    return unless GROUP_ON_FIELDS.include? group_field

    # The minus is used to sort_by in descending order
    group(group_field).calculate(aggregate, col).sort_by { |k, v| [-v, k] }
  end
end

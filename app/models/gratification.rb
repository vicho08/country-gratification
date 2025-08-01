# frozen_string_literal: true

class Gratification
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :country, :string
  attribute :monthly_base_salary, :integer
  attribute :minimum_monthly_income, :integer
  attribute :daily_salary, :integer
  attribute :days_worked_year, :integer
  attribute :monthly_salary, :integer
  attribute :worked_days_in_semester, :integer

  validates :country, presence: true
  validate :validate_strategy

  def strategy
    case country
    when 'Chile'
      Gratifications::ChileGratification.new(self)
    when 'México'
      Gratifications::MexicoGratification.new(self)
    when 'Colombia'
      Gratifications::ColombiaGratification.new(self)
    end
  end

  def validate_strategy
    s = strategy
    return if s.nil? || s.valid?

    s.errors.each do |error|
      errors.add(error.attribute, error.message)
    end
  end

  def result
    return unless valid?

    strategy.calculate
  end

  def fields
    return [] unless strategy.present?

    strategy.fields
  end
end

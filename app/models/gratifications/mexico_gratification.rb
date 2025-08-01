# frozen_string_literal: true

# app/models/gratifications/mexico_gratification.rb
module Gratifications
  class MexicoGratification < Gratifications::BaseGratification
    include ActiveModel::Model

    param_fields :daily_salary, :days_worked_year
    label_fields 'Salario diario', 'Días trabajados en el año'

    attr_reader :daily_salary, :days_worked_year

    validates :daily_salary, presence: true, numericality: { greater_than: 0, only_integer: true }
    validates :days_worked_year, presence: true,
                                 numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 365 }
    def initialize(gratification)
      super(gratification)
      @daily_salary = gratification&.daily_salary
      @days_worked_year = gratification&.days_worked_year
    end

    def calculate
      @daily_salary * 15 * (@days_worked_year / 365.0)
    end
  end
end

# frozen_string_literal: true

module Gratifications
  class ChileGratification < Gratifications::BaseGratification
    include ActiveModel::Model

    param_fields :monthly_base_salary, :minimum_monthly_income
    label_fields 'Sueldo base mensual', 'Ingreso mínimo mensual'

    attr_reader :monthly_base_salary, :minimum_monthly_income

    validates :monthly_base_salary, presence: true, numericality: { greater_than: 0, only_integer: true }
    validates :minimum_monthly_income, presence: true, numericality: { greater_than: 0, only_integer: true }

    def initialize(gratification)
      super(gratification)
      @monthly_base_salary = gratification&.monthly_base_salary
      @minimum_monthly_income = gratification&.minimum_monthly_income
    end

    def calculate
      base = @monthly_base_salary.to_d * 12 * 0.25
      cap  = @minimum_monthly_income.to_d * 4.75
      [base, cap].min
    end
  end
end

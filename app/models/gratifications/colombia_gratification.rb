# frozen_string_literal: true

# app/models/gratifications/colombia_gratification.rb
module Gratifications
  class ColombiaGratification < Gratifications::BaseGratification
    include ActiveModel::Model

    param_fields :monthly_salary, :worked_days_in_semester
    label_fields 'Salario mensual', 'Días trabajados en el semestre'

    attr_reader :monthly_salary, :worked_days_in_semester

    validates :monthly_salary, presence: true, numericality: { greater_than: 0, only_integer: true }
    validates :worked_days_in_semester, presence: true,
                                        numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 180 }
    def initialize(gratification)
      super(gratification)
      @monthly_salary = gratification.monthly_salary
      @worked_days_in_semester = gratification.worked_days_in_semester
    end

    def calculate
      (@monthly_salary * @worked_days_in_semester) / 360.0
    end
  end
end

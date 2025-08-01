# frozen_string_literal: true

class GratificationsController < ApplicationController
  def new
    @gratification = Gratification.new
  end

  def create
    @gratification = Gratification.new(gratification_params)
    @submitted = other_params.any?
    @result = @gratification.result if @gratification.valid?

    render :new
  end

  private

  def gratification_params
    params.require(:gratification).permit(
      :country,
      :monthly_base_salary,
      :minimum_monthly_income,
      :daily_salary,
      :days_worked_year,
      :monthly_salary,
      :worked_days_in_semester
    )
  end

  def other_params
    gratification_params.except(:country).values.reject(&:blank?)
  end
end

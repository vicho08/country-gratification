# frozen_string_literal: true

require 'rails_helper'
require 'ostruct'

RSpec.describe Gratifications::MexicoGratification do
  let(:valid_attrs) { OpenStruct.new(daily_salary: 500, days_worked_year: 300) }
  let(:invalid_attrs) { OpenStruct.new(daily_salary: nil, days_worked_year: nil) }

  context 'validations' do
    it 'is valid with valid attributes' do
      grat = described_class.new(valid_attrs)
      expect(grat).to be_valid
    end

    it 'is invalid with nil attributes' do
      grat = described_class.new(invalid_attrs)
      expect(grat).not_to be_valid
      expect(grat.errors[:daily_salary]).to include('no puede estar en blanco')
    end
  end

  context 'calculation' do
    it 'calculates the bonus correctly' do
      grat = described_class.new(OpenStruct.new(daily_salary: 500, days_worked_year: 300))
      expected = 500 * 15 * (300.0 / 365)
      expect(grat.calculate).to eq expected
    end
  end
end

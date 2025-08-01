# frozen_string_literal: true

require 'rails_helper'
require 'ostruct'

RSpec.describe Gratifications::ChileGratification do
  let(:valid_attrs) { OpenStruct.new(monthly_base_salary: 1_000_000, minimum_monthly_income: 600_000) }
  let(:invalid_attrs) { OpenStruct.new(monthly_base_salary: nil, minimum_monthly_income: nil) }

  context 'validations' do
    it 'is valid with valid attributes' do
      grat = described_class.new(valid_attrs)
      expect(grat).to be_valid
    end

    it 'is invalid with nil attributes' do
      grat = described_class.new(invalid_attrs)
      expect(grat).not_to be_valid
      expect(grat.errors[:monthly_base_salary]).to include('no puede estar en blanco')
    end
  end

  context 'calculation' do
    it 'calculates the minimum between base and cap' do
      grat = described_class.new(OpenStruct.new(monthly_base_salary: 1_000_000, minimum_monthly_income: 600_000))
      expected_base = 1_000_000 * 12 * 0.25
      expected_cap = 600_000 * 4.75
      expect(grat.calculate).to eq [expected_base, expected_cap].min
    end
  end
end

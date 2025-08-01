# frozen_string_literal: true

# spec/models/gratifications/colombia_gratification_spec.rb
require 'rails_helper'
require 'ostruct'

RSpec.describe Gratifications::ColombiaGratification do
  let(:valid_attrs) { OpenStruct.new(monthly_salary: 1_200_000, worked_days_in_semester: 120) }
  let(:invalid_attrs) { OpenStruct.new(monthly_salary: nil, worked_days_in_semester: nil) }
  let(:out_of_range_attrs) { OpenStruct.new(monthly_salary: 1_200_000, worked_days_in_semester: 300) }

  context 'validations' do
    it 'is valid with valid attributes' do
      grat = described_class.new(valid_attrs)
      expect(grat).to be_valid
    end

    it 'is invalid with nil attributes' do
      grat = described_class.new(invalid_attrs)
      expect(grat).not_to be_valid
      expect(grat.errors[:monthly_salary]).to include('no puede estar en blanco')
      expect(grat.errors[:worked_days_in_semester]).to include('no puede estar en blanco')
    end

    it 'is invalid when worked_days_in_semester is greater than 180' do
      grat = described_class.new(out_of_range_attrs)
      expect(grat).not_to be_valid
      expect(grat.errors[:worked_days_in_semester]).to include('debe ser menor o igual a 180')
    end
  end

  context 'calculation' do
    it 'calculates the legal bonus correctly' do
      grat = described_class.new(valid_attrs)
      expected = (1_200_000 * 120) / 360.0
      expect(grat.calculate).to eq expected
    end
  end
end

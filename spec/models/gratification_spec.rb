# spec/models/gratification_spec.rb
require 'rails_helper'
require 'ostruct'

RSpec.describe Gratification do
  describe "validations" do
    it "is invalid without a country" do
      grat = described_class.new
      expect(grat).not_to be_valid
      expect(grat.errors[:country]).to include("no puede estar en blanco")
    end

    it "is valid for Chile with correct attributes" do
      grat = described_class.new(
        country: "Chile",
        monthly_base_salary: 1_000_000,
        minimum_monthly_income: 600_000
      )
      expect(grat).to be_valid
    end

    it "is invalid for Chile if attributes are missing" do
      grat = described_class.new(
        country: "Chile"
      )
      expect(grat).not_to be_valid
      expect(grat.errors[:monthly_base_salary]).to include("no puede estar en blanco")
      expect(grat.errors[:minimum_monthly_income]).to include("no puede estar en blanco")
    end

    it "is valid for México with correct attributes" do
      grat = described_class.new(
        country: "México",
        daily_salary: 500,
        days_worked_year: 200
      )
      expect(grat).to be_valid
    end

    it "is invalid for México if attributes are missing" do
      grat = described_class.new(
        country: "México"
      )
      expect(grat).not_to be_valid
      expect(grat.errors[:daily_salary]).to include("no puede estar en blanco")
      expect(grat.errors[:days_worked_year]).to include("no puede estar en blanco")
    end

    it "is valid for Colombia with correct attributes" do
      grat = described_class.new(
        country: "Colombia",
        monthly_salary: 1_200_000,
        worked_days_in_semester: 120
      )
      expect(grat).to be_valid
    end

    it "is invalid for Colombia if attributes are missing" do
      grat = described_class.new(
        country: "Colombia"
      )
      expect(grat).not_to be_valid
      expect(grat.errors[:monthly_salary]).to include("no puede estar en blanco")
      expect(grat.errors[:worked_days_in_semester]).to include("no puede estar en blanco")
    end
  end

  describe "#result" do
    it "calculates the correct result for Chile" do
      grat = described_class.new(
        country: "Chile",
        monthly_base_salary: 1_000_000,
        minimum_monthly_income: 600_000
      )
      expected = [1_000_000 * 12 * 0.25, 600_000 * 4.75].min
      expect(grat.result).to eq expected
    end

    it "calculates the correct result for México" do
      grat = described_class.new(
        country: "México",
        daily_salary: 500,
        days_worked_year: 200
      )
      expected = 500 * 15 * (200.0 / 365)
      expect(grat.result).to eq expected
    end

    it "calculates the correct result for Colombia" do
      grat = described_class.new(
        country: "Colombia",
        monthly_salary: 1_200_000,
        worked_days_in_semester: 120
      )
      expected = (1_200_000 * 120) / 360.0
      expect(grat.result).to eq expected
    end

    it "returns nil if invalid" do
      grat = described_class.new(country: "Chile")
      expect(grat.result).to be_nil
    end
  end

  describe "#fields" do
    it "returns the correct fields for Chile" do
      grat = described_class.new(country: "Chile")
      expect(grat.fields).to eq([[:monthly_base_salary, "Sueldo base mensual"], [:minimum_monthly_income, "Ingreso mínimo mensual"]])
    end
  end
end

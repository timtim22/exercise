require "rails_helper"

RSpec.describe Excavator, type: :model do
  describe "columns" do
    it "has the expected columns" do
      expected_columns = %w[id company_name address crew_on_site ticket_id created_at updated_at]
      actual_columns = Excavator.column_names

      expect(actual_columns).to match_array(expected_columns)
    end
  end

  describe "associations" do
    it "belongs to a Ticket" do
      association = Excavator.reflect_on_association(:ticket)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end

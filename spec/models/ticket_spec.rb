require "rails_helper"

RSpec.describe Ticket, type: :model do
  describe "columns" do
    it "has the expected columns" do
      expected_columns = %w[id request_number sequence_number request_type request_action date_times service_area digsite_info created_at updated_at]
      actual_columns = Ticket.column_names

      expect(actual_columns).to match_array(expected_columns)
    end
  end

  describe "associations" do
    it "has a one-to-one association with Excavator" do
      association = Ticket.reflect_on_association(:excavator)
      expect(association.macro).to eq(:has_one)
    end
  end
end

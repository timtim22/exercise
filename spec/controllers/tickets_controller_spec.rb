require "rails_helper"

RSpec.describe TicketsController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns all tickets to @tickets" do
      ticket1 = FactoryBot.create(:ticket)
      ticket2 = FactoryBot.create(:ticket)

      get :index
      expect(assigns(:tickets)).to match_array([ticket1, ticket2])
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      ticket = FactoryBot.create(:ticket)

      get :show, params: { id: ticket.id }
      expect(response).to be_successful
    end

    it "assigns the requested ticket to @ticket" do
      ticket = FactoryBot.create(:ticket)

      get :show, params: { id: ticket.id }
      expect(assigns(:ticket)).to eq(ticket)
    end

    it "assigns the associated excavator to @excavator" do
      ticket = FactoryBot.create(:ticket)
      excavator = FactoryBot.create(:excavator, ticket: ticket)

      get :show, params: { id: ticket.id }
      expect(assigns(:excavator)).to eq(excavator)
    end
  end

  describe "POST #create" do
    context "with valid data" do
      let(:valid_data) do
        {
          RequestNumber: "123",
          SequenceNumber: 456,
          RequestType: "Type",
          RequestAction: "true",
          DateTimes: { ResponseDueDateTime: "2011/07/13 00:00:00"},
          ServiceArea: { PrimaryServiceAreaCode: {SACode: "ZZGL103"}, AdditionalServiceAreaCodes: {SACode: ["ZZGL103"]} },
          Excavator: { CompanyName: "CompanyName", Address: "Address", CrewOnsite: true },
          ExcavationInfo: { DigsiteInfo: {WellKnownText: "..."} }

        }
      end

      it "creates a new ticket and excavator" do
        expect {
          post :create, body: valid_data.to_json
        }.to change { Ticket.count }.by(1).and change { Excavator.count }.by(1)
      end

      it "returns a JSON response with the created ticket and excavator" do
        post :create, body: valid_data.to_json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to start_with("application/json")

        response_body = JSON.parse(response.body)
        expect(response_body["ticket"]).not_to be_nil
        expect(response_body["excavator"]).not_to be_nil
      end
    end

    context "with invalid data" do
      let(:invalid_data) do
        {
          request_number: "123"
          # Missing required attributes
        }
      end

      it "does not create a new ticket or excavator" do
        expect {
          post :create, body: invalid_data.to_json
        }.not_to change { Ticket.count }
      end

      it "returns a JSON response with an error message" do
        post :create, body: invalid_data.to_json

        expect(response).to have_http_status(:unprocessable_entity)
        response_body = JSON.parse(response.body)
        expect(response_body["error"]).not_to be_nil
      end
    end
  end
end

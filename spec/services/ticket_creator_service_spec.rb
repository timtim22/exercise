require 'rails_helper'

RSpec.describe TicketCreatorService do
  let(:data) do
    {
      'RequestNumber' => '123',
      'SequenceNumber' => '1',
      'RequestType' => 'Type',
      'RequestAction' => 'Action',
      'DateTimes' => { 'ResponseDueDateTime' => '2023-01-01' },
      'ServiceArea' => {
        'PrimaryServiceAreaCode' => { 'SACode' => 'Code1' },
        'AdditionalServiceAreaCodes' => { 'SACode' => 'Code2' }
      },
      'ExcavationInfo' => {
        'DigsiteInfo' => { 'WellKnownText' => 'POLYGON(...)' }
      },
      'Excavator' => {
        'CompanyName' => 'Company',
        'Address' => 'Address',
        'CrewOnsite' => true
      }
    }
  end

  describe '#create' do
    it 'creates a new ticket and excavator' do
      service = TicketCreatorService.new(data)

      expect { service.create }.to change { Ticket.count }.by(1).and change { Excavator.count }.by(1)

      result = service.create
      ticket = result[:ticket]
      excavator = result[:excavator]

      expect(ticket).to be_a(Ticket)
      expect(excavator).to be_a(Excavator)

      expect(ticket.request_number).to eq(123)
      expect(ticket.sequence_number).to eq(1)
      expect(ticket.request_type).to eq('Type')
      expect(ticket.request_action).to eq('Action')
      expect(ticket.date_times).to eq('ResponseDueDateTime' => '2023-01-01')
      expect(ticket.service_area).to eq(
        'ServiceArea' => {
          'PrimaryServiceAreaCode' => { 'SACode' => 'Code1' },
          'AdditionalServiceAreaCodes' => { 'SACode' => 'Code2' }
        }
      )
      expect(ticket.digsite_info).to eq('DigsiteInfo' => 'POLYGON(...)')

      expect(excavator.company_name).to eq('Company')
      expect(excavator.address).to eq('Address')
      expect(excavator.crew_on_site).to be_truthy
      expect(excavator.ticket).to eq(ticket)
    end
  end
end

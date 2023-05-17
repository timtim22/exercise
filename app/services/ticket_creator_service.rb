class TicketCreatorService
  
  def initialize(data)
    @data = data
  end

  def create
    ticket = create_ticket
    excavator = create_excavator(ticket)
    { ticket: ticket, excavator: excavator }
  end

  private

  def create_ticket
    ticket = Ticket.new
    ticket.request_number = @data['RequestNumber']
    ticket.sequence_number = @data['SequenceNumber']
    ticket.request_type = @data['RequestType']
    ticket.request_action = @data['RequestAction']
    ticket.date_times = { 'ResponseDueDateTime' => @data['DateTimes']['ResponseDueDateTime'] }
    ticket.service_area = {
      'ServiceArea' => {
        'PrimaryServiceAreaCode' => { 'SACode' => @data['ServiceArea']['PrimaryServiceAreaCode']['SACode'] },
        'AdditionalServiceAreaCodes' => { 'SACode' => @data['ServiceArea']['AdditionalServiceAreaCodes']['SACode'] }
      }
    }
    ticket.digsite_info = { 'DigsiteInfo' => @data['ExcavationInfo']['DigsiteInfo']['WellKnownText'] }
    ticket.save!
    ticket
  end

  def create_excavator(ticket)
    excavator = Excavator.new
    excavator.company_name = @data['Excavator']['CompanyName']
    excavator.address = @data['Excavator']['Address']
    excavator.crew_on_site = @data['Excavator']['CrewOnsite']
    excavator.ticket_id = ticket.id
    excavator.save!
    excavator
  end
end

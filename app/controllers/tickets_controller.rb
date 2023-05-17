class TicketsController < ApplicationController
  before_action :schema_validation, only: [:create]

  def index
    @tickets = Ticket.all
  end

  def show
    @ticket = Ticket.find(params[:id])
    @excavator = @ticket.excavator
  end

  def create
    data = JSON.parse(request.body.read)
  
    ticket_creator = TicketCreatorService.new(data)
    result = ticket_creator.create
    render json: { ticket: result[:ticket], excavator: result[:excavator] }, status: :created
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def schema_validation
    schema = JSON.parse(File.read(Rails.root.join('config', 'schema', 'ticket_schema.json')))
    validation_errors = JSON::Validator.fully_validate(schema, JSON.parse(request.body.read))

    render json: { error: validation_errors }, status: :unprocessable_entity if validation_errors.size > 0
  end
end

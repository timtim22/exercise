FactoryBot.define do
  factory :excavator do
    company_name { "test" }
    address { "test" }
    crew_on_site { true }
    ticket_id { 1 }
  end
end

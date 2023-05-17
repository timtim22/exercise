FactoryBot.define do
  factory :ticket do
    request_number { "123" }
    sequence_number { "456" }
    request_type { "Type" }
    request_action { "Action" }
    date_times { { start_date_time: "2022-01-01T00:00:00Z" } }
    service_area { { polygon: "..." } }
    digsite_info { { polygon: "..." } }
  end
end

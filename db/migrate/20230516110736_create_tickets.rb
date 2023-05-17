class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.integer :request_number
      t.integer :sequence_number
      t.string :request_type
      t.string :request_action
      t.jsonb :date_times, default: {}
      t.jsonb :service_area, default: {}
      t.jsonb :digsite_info, default: {}

      t.timestamps
    end

    add_index :tickets, :date_times, using: :gin
    add_index :tickets, :service_area, using: :gin
    add_index :tickets, :digsite_info, using: :gin
  end
end

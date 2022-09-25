FactoryBot.define do
  factory :reserved_slot do
    reservation_name { Faker::Name.name }
    start_time { '2022-09-22 16:30:00' }
    end_time { '2022-09-22 17:00:00' }
    uuid { Faker::Internet.uuid }
    warehouse { association(:warehouse) }
  end
end

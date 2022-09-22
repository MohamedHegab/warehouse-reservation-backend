FactoryBot.define do
  factory :business_hour do
    warehouse { association(:warehouse) }
    day { rand(0..6) }
    open_time { '00:00' }
    close_time { '21:59' }
  end
end

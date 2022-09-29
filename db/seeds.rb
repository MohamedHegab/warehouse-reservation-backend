first_warehouse = Warehouse.find_or_create_by(name: 'Warehouse 1')
second_warehouse = Warehouse.find_or_create_by(name: 'Warehouse 2')
third_warehouse = Warehouse.find_or_create_by(name: 'Warehouse 3')

for day in 0..4 do
  BusinessHour.find_or_create_by(warehouse: first_warehouse, day:, open_time: '08:00', close_time: '21:00')
end

for day in 0..5 do
  BusinessHour.find_or_create_by(warehouse: second_warehouse, day:, open_time: '00:00', close_time: '22:00')
end

for day in 0..6 do
  BusinessHour.find_or_create_by(warehouse: third_warehouse, day:, open_time: '10:00', close_time: '24:00')
end

ReservedSlot.find_or_create_by(warehouse: first_warehouse, reservation_name: 'Goods', start_time: '2022-09-29T18:00:00.000Z',
                               end_time: '2022-09-29T20:30:00.000Z')
ReservedSlot.find_or_create_by(warehouse: first_warehouse, reservation_name: 'Goods', start_time: '2022-09-28T10:00:00.000Z',
                               end_time: '2022-09-28T12:30:00.000Z')
ReservedSlot.find_or_create_by(warehouse: first_warehouse, reservation_name: 'Goods', start_time: '2022-09-29T08:00:00.000Z',
                               end_time: '2022-09-29T12:00:00.000Z')

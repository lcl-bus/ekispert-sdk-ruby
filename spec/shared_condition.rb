RSpec.shared_context 'shared Condition' do
  let(:default_params) {
    {
      'plane' => 'normal',
      'shinkansen' => 'normal',
      'shinkansen_nozomi' => 'normal',
      'sleeper_train' => 'never',
      'limited_express' => 'normal',
      'highway_bus' => 'normal',
      'connection_bus' => 'normal',
      'local_bus' => 'normal',
      'ship' => 'normal',
      'liner' => 'normal',
      'walk' => 'normal',
      'midnight_bus' => 'never',
      'surcharge_kind' => 'free',
      'teiki_kind' => 'bussiness',
      'jr_seasonal_rate' => 'true',
      'student_discount' => 'false',
      'ticket_system_type' => 'normal',
      'nikukanteiki' => 'false',
      'preferred_ticket_order' => 'none',
      'jr_reservation' => 'none',
      'use_jr' => 'normal',
      'transfer' => 'normal',
      'express_starting_station' => 'normal',
      'wait_average_time' => 'true',
      'local_bus_only' => 'false',
      'fuzzy_line' => 'false',
      'transfer_time' => 'normal',
      'entry_path_behavior' => 'false'
    }
  }
  let(:default_detail) { 'T3221233232319:F332112212000:A23121141:' }
end

RSpec.shared_context 'shared Condition params' do
  let(:default_params) do
    default_traffic_params.merge(default_fee_params).merge(default_adjunctive_params)
  end
  let(:default_traffic_params) do
    {
      plane: 'normal',
      shinkansen: 'normal',
      shinkansen_nozomi: 'normal',
      sleeper_train: 'never',
      limited_express: 'normal',
      highway_bus: 'normal',
      connection_bus: 'normal',
      local_bus: 'normal',
      ship: 'normal',
      liner: 'normal',
      walk: 'normal',
      midnight_bus: 'never'
    }
  end
  let(:default_fee_params) do
    {
      surcharge_kind: 'free',
      teiki_kind: 'bussiness',
      jr_seasonal_rate: 'true',
      student_discount: 'false',
      ticket_system_type: 'normal',
      nikukanteiki: 'false',
      preferred_ticket_order: 'none',
      jr_reservation: 'none'
    }
  end
  let(:default_adjunctive_params) do
    {
      use_jr: 'normal',
      transfer: 'normal',
      express_starting_station: 'normal',
      wait_average_time: 'true',
      local_bus_only: 'false',
      fuzzy_line: 'false',
      transfer_time: 'normal',
      entry_path_behavior: 'false'
    }
  end
end
RSpec.shared_context 'shared Condition detail' do
  let(:default_detail) { "#{default_traffic_detail}#{default_fee_detail}#{default_adjunctive_detail}" }
  let(:default_traffic_detail) { 'T3221233232319:' }
  let(:default_fee_detail) { 'F332112212000:' }
  let(:default_adjunctive_detail) { 'A23121141:' }
end

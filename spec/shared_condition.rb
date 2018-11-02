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
  let(:custom_params) do
    custom_traffic_params.merge(custom_fee_params).merge(custom_adjunctive_params)
  end
  let(:custom_traffic_params) do
    {
      plane: 'bit',
      shinkansen: 'never',
      shinkansen_nozomi: 'never',
      sleeper_train: 'normal',
      limited_express: 'never',
      highway_bus: 'bit',
      connection_bus: 'bit',
      local_bus: 'never',
      ship: 'bit',
      liner: 'never',
      walk: 'little',
      midnight_bus: 'normal'
    }
  end
  let(:custom_fee_params) do
    {
      surcharge_kind: 'green',
      teiki_kind: 'university',
      jr_seasonal_rate: 'false',
      student_discount: 'true',
      ticket_system_type: 'ic',
      nikukanteiki: 'true',
      preferred_ticket_order: 'normal',
      jr_reservation: 'none'
    }
  end
  let(:custom_adjunctive_params) do
    {
      use_jr: 'bit',
      transfer: 'little',
      express_starting_station: 'possible',
      wait_average_time: 'false',
      local_bus_only: 'true',
      fuzzy_line: 'true',
      transfer_time: 'lessMargin',
      entry_path_behavior: 'true'
    }
  end
  let(:camelcase_params) do
    {
      plane: 'bit',
      shinkansen: 'never',
      shinkansenNozomi: 'never',
      sleeperTrain: 'normal',
      limitedExpress: 'never',
      highwayBus: 'bit',
      connectionBus: 'bit',
      localBus: 'never',
      ship: 'bit',
      liner: 'never',
      walk: 'little',
      midnightBus: 'normal',
      surchargeKind: 'green',
      teikiKind: 'university',
      JRSeasonalRate: 'false',
      studentDiscount: 'true',
      ticketSystemType: 'ic',
      nikukanteiki: 'true',
      preferredTicketOrder: 'normal',
      useJR: 'bit',
      transfer: 'little',
      expressStartingStation: 'possible',
      waitAverageTime: 'false',
      localBusOnly: 'true',
      fuzzyLine: 'true',
      transferTime: 'lessMargin',
      entryPathBehavior: 'true'
    }
  end
end
RSpec.shared_context 'shared Condition detail' do
  let(:default_detail) { "#{default_traffic_detail}#{default_fee_detail}#{default_adjunctive_detail}" }
  let(:default_traffic_detail) { 'T3221233232319:' }
  let(:default_fee_detail) { 'F332112212000:' }
  let(:default_adjunctive_detail) { 'A23121141:' }
  let(:custom_detail) { "#{custom_traffic_detail}#{custom_fee_detail}#{custom_adjunctive_detail}" }
  let(:custom_traffic_detail) { 'T2112122121229:' }
  let(:custom_fee_detail) { 'F111212122100:' }
  let(:custom_adjunctive_detail) { 'A12212212:' }
end

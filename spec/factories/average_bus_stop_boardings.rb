FactoryBot.define do
  factory :average_bus_stop_boarding do
    on_street { "BELMONT" }
    cross_street { "CICERO" }
    intersection { [on_street, cross_street].sort.join(' & ') }
    routes { 77 }
    boardings { 10 }
    alightings { 5 }
    month_beginning { "2012-10-01".to_date }
    daytype { "Weekday" }
    latitude { 1.5 }
    longitude { 1.5 }

    trait :addison do
      on_street { 'ADDISON' }
      routes { 152 }
    end

    trait :harlem do
      on_street { 'HARLEM' }
      routes { 90 }
    end

    facory :addison_route, traits: %i[addison]
    facory :harlem_route, traits: %i[harlem]
  end
end

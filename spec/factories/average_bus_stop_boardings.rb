FactoryBot.define do
  factory :average_bus_stop_boarding do
    on_street { "MyString" }
    cross_street { "MyString" }
    routes { 1 }
    boardings { 1.5 }
    alightings { 1.5 }
    month_beginning { "2019-05-11" }
    daytype { "MyString" }
    latitude { 1.5 }
    longitude { 1.5 }
  end
end

Ransack.configure do |config|
  config.add_predicate 'end_of_day_lteq',
    arel_predicate: 'lt',
    formatter: proc { |v| v.to_date.end_of_day },
    validator: proc { |v| v.present? },
    type: :string
end


class ExchangeStudy < Activity 
  belongs_to :study_program
  belongs_to :exchange_program
  belongs_to :country
end

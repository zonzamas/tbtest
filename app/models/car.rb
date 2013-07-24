class Car < ActiveRecord::Base

  #TODO This should go on its own Model class
  EU_COUNTRIES=["Austria","Belgium","Bulgaria","Croatia","Cyprus","Czech Republic","Denmark","Estonia","Finland","France","Germany","Greece","Hungary","Ireland","Italy","Latvia","Lithuania","Luxembourg","Malta","Netherlands","Poland","Portugal","Romania","Slovakia","Slovenia","Spain","Sweden","United Kingdom"]
  
  attr_accessible :brand, :country, :horsepower, :model, :number_plate, :owner, :register_date
  
  validates_presence_of :brand, :country, :horsepower, :model, :number_plate, :owner, :register_date
  
  validates_inclusion_of :country, :in => EU_COUNTRIES,
                    :message => 'is not an EU country'

  validates_format_of :number_plate, :with => /\d{4}\-[A-Z]{3}/,
                     :message => 'does not look like a standard plate number (1234-ABC) mind the capital letters'
  
  MAX_CAR_AGE = 30
  validates_inclusion_of :register_date, :in => Date.civil((Date.today.year - MAX_CAR_AGE),1,1) .. Date.today,
                     :message => "is older than #{MAX_CAR_AGE} years, hence it must follow an special procedure"


  validates_numericality_of :horsepower

  validates_uniqueness_of :number_plate, :case_sensitive => false,
                         :message => 'has already been registered'
  
  def available_countries
    EU_COUNTRIES
  end

  def max_car_age
    MAX_CAR_AGE
  end

end

require 'active_resource'
require 'base'
require 'resources/car'


module Dgtcli
  class CLI < Thor
    desc 'list', 'Lists all registered cars'
    def list
      cars = Dgtcli::Resources::Car.all.collect do |car|
        car.attributes
      end
      say "Found  #{cars.size} cars registered" ,:green
      print_table(cars)
    end

    desc 'remove NUMBERPLATE', 'Remove a car with the given number plate'
    def remove(numberplate)
      begin
        car = Dgtcli::Resources::Car.find(:all, :params => { :number_plate => numberplate }).first
        if car
          say "Removing #{car.attributes['brand']} with number plate #{car.attributes['number_plate']}", :green
          car.destroy
        else
          say "No car found with numberplate #{numberplate}", :yellow
        end
      rescue Exception => e
        say "Something went wrong", :red
      end
    end

    desc 'create', 'Add a new car with params in a hashlike form'
    option :carparams, :type => :hash , :required => true, :desc => 'A hash with the options'
    def create()
      car =  Dgtcli::Resources::Car.new(options[:carparams])
      if car.save
        say "Created #{car.attributes['id']}", :green
      else
        say "Failed to created #{options[:carparams]['brand']}", :red
      end
    end
  end
end

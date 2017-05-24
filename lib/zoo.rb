class ZooAtCapacity < StandardError
end

class Zoo
  attr_reader :cages, :employees
  def initialize(name, season_opening_date, season_closing_date)
    @season_opening_date = season_opening_date
    @season_closing_date = season_closing_date
    @cages = []
    10.times do
      @cages << Cage.new
    end
    @employees = []
  end

  def add_employee(employee)
    @employees << employee
  end

  def open?(date)
    date <= @season_closing_date && date >= @season_opening_date
  end

  def add_animal(animal)
    if @cages.any? { |cage| cage.empty? }
      @cages.each do |cage|
        if cage.empty?
          cage.animal = animal
          break
        end
      end
    else
      raise ZooAtCapacity
    end
  end

  def visit
    greeting = ""
    @employees.each do |employee|
      greeting += "#{employee.greet}\n"
    end
    @cages.each do |cage|
      if !cage.empty?
        greeting += "#{cage.animal.speak}\n"
      end
    end
    greeting
  end
end

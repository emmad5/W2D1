class Employee
  attr_reader :name, :title, :salary, :boss
  
  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end
  
  def bonus(multiplier)
    @bonus = (@salary) * multiplier
  end
  
end



class Manager < Employee
  attr_accessor :sub_employees
  
  def initialize(name, title, salary, boss)
    @sub_employees = []
    super
  end
  
  def add_employee(employee)
    @sub_employees << employee
    
  end
  
  def bonus(multiplier)
    sum = 0
    @sub_employees.each do |employee|
      sum += employee.bonus(multiplier)
      if employee.is_a? (Manager)
        sum += employee.salary * multiplier
      end
    end
    sum
  end
  
end
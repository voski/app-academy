class Employee
  attr_accessor :name, :salary, :title, :boss

  def initialize(name, salary, title, boss = nil)
    @name = name
    @salary = salary
    @title = title
    @boss = boss
    @team_members = []
    @boss.add_to_team(self) unless boss.nil?
  end

  def add_to_team(team_member)
    @team_members << team_member
  end

  def team_salary
    return 0 if @team_members.empty?
    team_salary = 0
    @team_members.each do |team_member|
      team_salary += team_member.salary
    end
    team_salary
  end

  def bonus(mult)
    @salary * mult
  end
end

class Manager < Employee
  def bonus(mult)
    total_team_sal = 0

    @team_members.each do |team_member|
      if team_member.is_a?(Manager)
        total_team_sal += team_member.team_salary + team_member.salary
      else
        total_team_sal += team_member.salary
      end

    end
    total_team_sal * mult
  end

end

ned = Manager.new("Ned", 1000000, 'Founder')
darren = Manager.new("Darren", 78000, "TA Manager",  ned)
shawna = Employee.new("Shawna", 12000,  "TA", darren )
david = Employee.new("david",  10000, "TA", darren )

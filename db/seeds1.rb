# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'rubygems'
require 'roo'

s = Excel.new("/home/shin/Dropbox/Personal/Project/Top_100_Thai_Companies_2012.xls")

s.default_sheet = 'SET100-EN'

for i in 4..110

  if s.cell('C', i).nil?
    industrygroup_name = s.cell('A', i).sub("Industry Group: ", "")

    if IndustryGroup.where(name: industrygroup_name).first == nil
      puts "IndustryGroup not exits"

      IndustryGroup.create(name: industrygroup_name)

    else
      puts "IndustryGroup exits"

    end

    pre_group =IndustryGroup.where(name: industrygroup_name).first
  else

    pre_group =IndustryGroup.last
    if Sector.where(name: s.cell('B', i)).first == nil
      puts "Sector not exits"
      pre_group.sectors.create(name: s.cell('B', i))
    else
      puts "Sector exits"
    end
    pre_sector = Sector.where(name: s.cell('B', i)).first

    if Company.where(symbol: s.cell('D', i)).first == nil
      puts "Company not exits"

      pre_sector.companies.create(name: s.cell('C', i), symbol: s.cell('D', i))
    else
      puts "Company exits"
    end

  end
end
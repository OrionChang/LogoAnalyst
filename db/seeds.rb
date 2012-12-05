# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pp'

url = "http://www.forbes.com/global2000/list/"

doc = Nokogiri::HTML(open(url))
rows = doc.xpath('//table/tbody/tr')

details = rows.collect do |row|


  detail = {}
  [
      [:rank, 'td[1]/text()'],
      [:name, 'td[2]/h3/text()'],
      [:country, 'td[3]/text()'],
      [:sales, 'td[4]/text()'],
      [:profit, 'td[5]/text()'],
      [:assets, 'td[6]/text()'],
      [:market_value, 'td[7]/text()'],
  ].each do |name, xpath|
    data = row.at_xpath(xpath).content.to_s.strip
    if data.include?('$')
      data = data.gsub(/[$]/, '')
      if data.include?('B')
        data = data.gsub(/[ b]/, '')
        data = data.gsub(/[ B]/, '')
        data = data.to_f
        data = data * 1000000000
      end
    end

    detail[name] = data
  end


  detail[:rank] = detail[:rank].to_i

  detail_url = "http://www.forbes.com" + row.at_xpath('td[2]/a/@rel').content.to_s.strip

  detail_doc = Nokogiri::HTML(open(detail_url))

  detail[:logo] = detail_doc.at('meta[@property="og:image"]')[:content].to_s.strip
  detail[:industry] = detail_doc.at('div[@class="stats"]/div[@class="ataglanz fleft"]/ul/li[1]/b/text()').content.to_s.strip
  detail[:website] = detail_doc.at('div[@class="stats"]/div[@class="ataglanz fleft"]/ul/li/a/@href').content.to_s.strip
  detail[:detail] = detail_url

  country = Country.find_or_create_by(name: detail[:country])
  industry = GlobalIndustry.find_or_create_by(name: detail[:industry])
  company = country.global_companies.new
  company.global_industry = industry
  company.name = detail[:name]
  profile = company.global_company_profiles.new
  profile.date_of_profiling = "2012-04-01"
  profile.attributes = {
      rank: detail[:rank], sales: detail[:sales], profit: detail[:profit], assets: detail[:assets], market_value: detail[:market_value], detail_url: detail[:detail], website_url: detail[:website]
  }

  profile.remote_logo_url = detail[:logo]

  profile.save
  company.save
  industry.save
  country.save

  puts "Done for " + detail[:name] + " in " + detail[:industry] + " of " + detail[:country]


end



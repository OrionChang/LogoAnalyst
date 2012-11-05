class Company
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :symbol, type: String

  belongs_to :sector
  embeds_many :profiles, cascade_callbacks: true


  class << self
    def random(n = 1)
      no_profile_company = Company.any_in("profiles" => nil)
      indexes = (0..no_profile_company.count-1).sort_by { rand }.slice(0, n)
      if n == 1
        return self.skip(indexes.first).first
      else
        return indexes.map { |index| self.skip(index).first }
      end

    end

    def profile_with_least_survey
      Company.any_of(:profiles.exists => true).all.asc('profiles.counter').limit(1).first.profiles.asc(:counter).limit(1).first
    end
  end
end

class Company
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :symbol, type: String

  belongs_to :sector

  embeds_many :profiles


  class << self
    def random(n = 1)
      no_profile_company = Company.any_in("profiles" => nil).collect!
      indexes = (0..no_profile_company.count-1).sort_by { rand }.slice(0, n).collect!
      if n == 1
        return self.skip(indexes.first).first
      else
        return indexes.map { |index| self.skip(index).first }
      end

    end
  end
end

class GlobalCompany
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :symbol, type: String

  belongs_to :country
  belongs_to :global_industry
  has_many :global_company_profiles


  accepts_nested_attributes_for :global_company_profiles
  after_create :inc_count
  after_destroy :dec_count

  def inc_count
    self.country.inc(:counter, 1)
    self.global_industry.inc(:counter, 1)
  end

  def dec_count
    self.country.inc(:counter, -1)
    self.global_industry.inc(:counter, -1)
  end
end

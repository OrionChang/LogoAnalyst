class GlobalCompanyProfile
  include Mongoid::Document
  include Mongoid::Timestamps


  field :website_url, type: String
  field :detail_url, type: String

  field :rank, type: Integer

  field :market_value, type: Integer
  field :sales, type: Integer
  field :profit, type: Integer
  field :assets, type: Integer

  field :date_of_profiling, type: Date
  field :beginning, type: Date
  field :ending, type: Date


  mount_uploader :logo, LogoUploader


  belongs_to :global_company

  after_create :inc_count
  after_destroy :dec_count

  def inc_count
    self.global_company.inc(:counter, 1)

  end

  def dec_count
    self.global_company.inc(:counter, -1)
  end

end

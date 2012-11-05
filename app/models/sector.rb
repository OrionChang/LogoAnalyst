class Sector
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  belongs_to :industry_group
  has_many :companies


end

class Profile
  include Mongoid::Document
  include Mongoid::Timestamps
  field :url, type: String
  field :beginning, type: Date
  field :ending, type: Date


  mount_uploader :logo, LogoUploader


  embedded_in :company
  has_many :surveys

  include Counter
  after_create :inc_count
  after_destroy :dec_count


end



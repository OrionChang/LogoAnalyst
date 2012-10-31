class Profile
  include Mongoid::Document
  include Mongoid::Timestamps
  field :url, type: String
  field :beginning, type: Date
  field :ending, type: Date


  mount_uploader :logo, LogoUploader


  embedded_in :company

end



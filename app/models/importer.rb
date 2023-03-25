class Importer < ApplicationRecord
  belongs_to :user

  has_one_attached :file

  validates :user, :file, presence: true

  def file_url
    ActiveStorage::Current.url_options = { host: ENV['DOMAIN_NAME'] }

    file.url
  end
end

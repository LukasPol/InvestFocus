class Importer < ApplicationRecord
  belongs_to :user

  has_one_attached :file

  validates :user, :file, presence: true

  def file_url
    ActiveStorage::Current.url_options = { host: ENV['DOMAIN_NAME'] }

    file.url
  end

  def finish_upload
    Turbo::StreamsChannel.broadcast_replace_to(user.id, :alerts,
                                               target: :alerts,
                                               partial: 'shared/imports/upload_completed',
                                               locals: { user: })
  end
end

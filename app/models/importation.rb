class Importation < ApplicationRecord
  self.table_name = 'importation'

  belongs_to :user

  has_one_attached :file

  validates :user, :file, presence: true

  enum status: { dont_started: 0, started: 1, finished: 2 }

  def file_url
    ActiveStorage::Current.url_options = { host: ENV['DOMAIN_NAME'] }

    file.url
  end

  def finish_upload
    update(status: :finished)
    Turbo::StreamsChannel.broadcast_replace_to(user.id, :alerts,
                                               target: :alerts,
                                               partial: 'shared/imports/upload_completed',
                                               locals: { user: })
  end
end

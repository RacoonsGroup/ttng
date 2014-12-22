require "google/api_client"
require "google_drive"

class GoogleExporter
  def self.upload_file(filepath)
    last_token = Token.last
    access_token = last_token.fresh_token
    session = GoogleDrive.login_with_oauth(access_token)
    file = session.upload_from_file(filepath)
    subfolders = session.root_collection.subcollections.map {|x|  x.title}
    binding.pry
    unless subfolders.include?('Reports from Racoons-Group Task Tracker')
      session.root_collection.create_subcollection('Reports from Racoons-Group Task Tracker')
    end
    session.collection_by_title('Reports from Racoons-Group Task Tracker').add(file)
    session.root_collection.remove(file)
  end
end
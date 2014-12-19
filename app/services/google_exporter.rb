require "google/api_client"
require "google_drive"

class GoogleExporter
  def self.upload_file(filepath, code)
    auth = Google::APIClient.new.authorization
    auth.code = code
    auth.fetch_access_token!
    access_token = auth.access_token
    session = GoogleDrive.login_with_oauth(access_token)
    file = session.upload_from_file(filepath)
    session.root_collection.create_subcollection('Reports from Racoons-Group Task Tracker')
    session.collection_by_title('Reports from Racoons-Group Task Tracker').add(file)
    session.root_collection.remove(file)
  end
end
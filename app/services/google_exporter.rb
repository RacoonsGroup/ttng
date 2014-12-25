require "google/api_client"
require "google_drive"

class GoogleExporter
  class_inject :current_user

  def self.upload_file(filepath)
    access_token = current_user.google_token
    session = GoogleDrive.login_with_oauth(access_token)
    file = session.upload_from_file(filepath)
    subfolders = session.root_collection.subcollections.map {|x|  x.title}

    unless subfolders.include?('Reports from Racoons-Group Task Tracker')
      session.root_collection.create_subcollection('Reports from Racoons-Group Task Tracker')
    end
    session.collection_by_title('Reports from Racoons-Group Task Tracker').add(file)
    session.root_collection.remove(file)
  end
end
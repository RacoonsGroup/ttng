require "google/api_client"
require "google_drive"

class GoogleExporter
  client = Google::APIClient.new
  auth = client.authorization
  auth.client_id = '109932807530-pngovokf6v5l16170ra8e2juujj4benp.apps.googleusercontent.com'
  auth.client_secret = '8coKcy6T_i-kj1v_WQbUomTv'
  auth.scope =
      "https://www.googleapis.com/auth/drive " +
      "https://docs.google.com/feeds/ " +
      "https://docs.googleusercontent.com/ " +
      "https://spreadsheets.google.com/feeds/"
  auth.redirect_uri = 'urn:ietf:wg:oauth:2.0:oob'
  print("1. Open this page:\n%s\n\n" % auth.authorization_uri)
  auth.code = '4/3qg4wksaV6W7zw1F7i3ZeF4Ppdqez0OHHIvOYMJd1ls.Ahs3SBENjf0QrjMoGjtSfToKP_26lAI'
  auth.fetch_access_token!

  def self.upload_file(filepath)
    access_token = auth.access_token
    session = GoogleDrive.login_with_oauth(access_token)
    file = session.upload_from_file(filepath)
    session.root_collection.create_subcollection('Reports from Racoons-Group Task Tracker')
    session.collection_by_title('Reports from Racoons-Group Task Tracker').add(file)
    session.root_collection.remove(file)
  end
end
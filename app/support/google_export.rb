require "google/api_client"
require "google_drive"

class GoogleExport
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
  # print("1. Open this page:\n%s\n\n" % auth.authorization_uri)
  auth.code = '4/uyqM9EzAjl2yDmgMWv6RQpLjgOKALCLUX4dnjwDFqOo.Uv1opr3KSnQUrjMoGjtSfTp-r5-vlAI'
  auth.fetch_access_token!
  access_token = auth.access_token

  @session = GoogleDrive.login_with_oauth(access_token)

  def self.upload_file(filepath)
    file = @session.upload_from_file(filepath)
    @session.root_collection.create_subcollection('export')
    @session.collection_by_title('export').add(file)
    @session.root_collection.remove(file)
  end
end
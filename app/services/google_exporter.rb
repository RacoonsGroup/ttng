require 'google/api_client'
require 'google_drive'

class GoogleExporter
  ROOT_FOLDER = 'Racoons Group Reports'

  inject :current_user

  def upload_file(project:, content:)
    file_path = write_content(content)

    session = GoogleDrive.login_with_oauth(token)
    file = session.upload_from_file(file_path)

    create_folder(session.root_collection, ROOT_FOLDER) do |folder|
      create_folder(folder, project.name) do |project_folder|
        project_folder.add(file)
      end
      session.root_collection.remove(file)
    end
  end

  private

  def token
    current_user.google_token
  end

  def write_content(content)
    file_path = "#{Rails.root}/tmp/#{DateTime.now.strftime("%d.%m.%Y %H:%M:%S")}.xlsx"
    File.open(file_path, 'w') { |file| file.write(content) }
    file_path
  end

  def create_folder(collection, name)
    unless collection.subcollections.map(&:title).include?(name)
      collection.create_subcollection(name)
    end
    yield collection.subcollection_by_title(name)
  end
end
class CollectionMock < Mock
  def title
    'collection'
  end


  def subcollection_by_title(name)
    CollectionMock.new
  end

  def subcollections
    [CollectionMock.new]
  end
end


class SessionMock
  def upload_from_file(path)

  end

  def root_collection
    CollectionMock.new
  end
end

class GoogleDriveMock
  def self.login_with_oauth(token)
    SessionMock.new
  end
end
require_relative 'mock.rb'

class ManagerMock < Mock
  def method_missing(name, *args, &block)
    yield item, result if block_given?
  end

  def result
    false
  end

  def item
    nil
  end
end
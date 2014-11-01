class Permitter
  class << self
    def fields(array=nil)
      if array.present?
        @fields = array
      else
        @fields
      end
    end

    def namespace(namespace=nil)
      if namespace.present?
        @namespace = namespace
      else
        @namespace
      end
    end

    def after_permit(&block)
      @after_permit = block
    end

    def permit(params)
      permitted = pickup_ids(params.require(namespace).permit(fields))
      @after_permit.call(permitted) if @after_permit.present?
      permitted
    end

    private

    def pickup_ids(hash)
      hash.inject(HashWithIndifferentAccess.new) do |res, (k, v)|
        if v.is_a?(Hash) && v[:id].present?
          res[:"#{k}_id"] = v[:id]
        else
          res[k] = v
        end
        res
      end
    end
  end
end
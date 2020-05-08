module Histock
    class Error < StandardError
    end

    class InformationNotFound < Error; end

    class XMLNodeSetError < Error; end

    class TableFormatError < Error; end
    class TableHeaderError < Error; end
    class TableBodyError < Error; end
end

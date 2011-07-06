module Net
  class DAV
    # Hold items found using Net::DAV#find
    class Item
      # URI of item
      attr_reader :uri

      # Size of item if a file
      attr_reader :size

      # Type of item - :directory or :file
      attr_reader :type

      # display name
      attr_reader :displayname

      # file/directory create date
      attr_reader :creationdate

      # file/directory last modified time
      attr_reader :lastmodified
      
      # is the file/directory hidden?
      attr_reader :ishidden
      
      # mime type of file
      attr_reader :contenttype

      # Synonym for uri
      def url
        @uri
      end

      def initialize(dav, uri, type, size, displayname, creationdate, lastmodified, ishidden, contenttype) #:nodoc:
        @dav = dav
        @uri = uri
        @type = type
        @size = size.to_i rescue nil
        @displayname = displayname
        @creationdate = creationdate
        @lastmodified = lastmodified
        @ishidden = ishidden
        @contenttype = contenttype
      end

      # Get content from server if needed and return as string
      def content
        return @content unless @content.nil?
        @content = @dav.get(@uri.path)
      end

      # Put content to server
      def content=(str)
        @dav.put_string(@uri.path, str)
        @content = str
      end

      # Proppatch item
      def proppatch(xml_snippet)
        @dav.proppatch(@uri.path,xml_snippet)
      end

      #Properties for this item
      def propfind
        return @dav.propfind(@uri.path)
      end

      def to_s #:nodoc:
        "#<Net::DAV::Item URL:#{@uri.to_s} type:#{@type}>"
      end

      def inspect #:nodoc:
        "#<Net::DAV::Item URL:#{@uri.to_s} type:#{@type}>"
      end
    end
  end
end

module ReverseMarkdown
  module Converters
    class Code < Base
      def convert(node, index)
        "`#{node.text}`"
      end
    end
  end
end

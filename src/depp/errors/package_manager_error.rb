# frozen_string_literal: true

module Depp
  module Errors
    class PackageManagerError < StandardError
      def initialize(msg='the package manager encountered an error')
        super
      end
    end
  end
end

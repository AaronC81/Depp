# frozen_string_literal: true

module Depp
  # Represents a single version of a package available on a package manager.
  class PackageInfo
    def initialize(name, version, package_manager, dependencies = nil)
      @name = name
      @version = version
      @package_manager = package_manager
      @dependencies = dependencies
    end

    # The name of this package.
    attr_reader :name
    
    # This version of the package.
    attr_reader :version
    
    # The +PackageManager+ which this package belongs to.
    attr_reader :package_manager

    # The dependencies of this package, as an +Array+ of +PackageInfo+ objects.
    # This might be fetched from the package manager the first time it is
    # accessed.
    def dependencies
      if dependencies.nil?
        @dependencies = package_manager.package_dependencies(self)
      end

      @dependencies
    end
  end
end

# frozen_string_literal: true

module Depp
  # The state of a package on the local machine.
  class PackageStatus
    def initialize(name, installed_version, package_manager)
      @name = name
      @installed_version = installed_version
      @package_manager = package_manager
    end

    # The name of this package.
    attr_reader :name

    # The version of this package which is installed, or nil if it is not.
    attr_reader :installed_version

    # The +PackageManager+ which this package belongs to.
    attr_reader :package_manager

    # Whether any version of this package is already installed or not.
    def installed?; !installed_version.nil?; end
  end
end

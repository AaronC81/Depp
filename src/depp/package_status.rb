# frozen_string_literal: true

module Depp
  # The state of a package on the local machine.
  class PackageStatus
    def initialize(installed_version, package_manager)
      @installed_version = installed_version
      @package_manager = package_manager
    end

    # The version of this package which is installed, or nil if it is not.
    attr_accessor :installed_version

    # The +PackageManager+ which this package belongs to.
    attr_reader :package_manager

    # Whether any version of this package is already installed or not.
    def installed?; !installed_version.nil?; end
  end
end

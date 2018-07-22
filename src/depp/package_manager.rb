# frozen_string_literal: true

require 'depp/errors/package_manager_error'

module Depp
  # An abstract class for a package manager available to Depp.
  # A subclass of +PackageManager+ is expected to implement:
  #
  #   - +__package_info__+
  #   - +__package_status__+
  #   - +__install_package__+
  #   - +__present__+
  #   - +__package_dependencies__+
  #
  class PackageManager
    # Checks that the current package manager is implemented in a valid manner;
    # that is, any required methods have been implemented by the subclass.
    # If this isn't the case, an exception is thrown.
    def valid_implementation!
      required_methods = [
        :__package_info__,
        :__package_status__,
        :__install_package__,
        :__present__,
        :__package_dependencies__
      ]

      required_methods.each do |required_method|
        next if respond_to? required_method
        raise Errors::PackageManagerError,
          "incorrect implementation (#{required_method} not implemented)"
      end

      true
    end

    # Checks whether the package manager is present and ready to use, returning
    # true if it is and false if it isn't.
    def present?
      __present__
    end

    # Asserts that the package manager is present and ready to use.
    def present!
      raise Errors::PackageManagerError,
        'package manager is not available' unless present?

      true
    end

    # Gets information about a package, returning a +PackageInfo+ object.
    # If the package does not exist, returns nil.
    # +name+::The name of the package.
    # +version+:: The version of the package, default latest.
    def package_info(name, version='latest')
      valid_implementation!
      present!
      __package_info__(name, version)
    end

    # Gets the status of a package on the local machine, returning a
    # +PackageStatus+ object.
    # +name+::The name of the package.
    def package_status(name)
      valid_implementation!
      present!
      __package_status__(name)  
    end

    # Installs a package to the local machine.
    # +package+:: A +PackageInfo+ object representing this package.
    def install_package(name)
      valid_implementation!
      present!
      __install_package__(name)
    end

    # Gets the dependencies for a given package, as an +Array+ of +PackageInfo+
    # objects.
    def package_dependencies(package)
      valid_implementation!
      present!
      __package_dependencies__(package)
    end
  end
end
# frozen_string_literal: true

require 'open3'

require 'depp/errors/package_manager_error'

module Depp
  # An abstract class for a package manager available to Depp.
  # A subclass of +PackageManager+ is expected to implement:
  #
  #   - +__packages_by_name__(name)+
  #   - +__package_status__(name)+
  #   - +__install_package__(package)+
  #   - +__present__()+
  #
  # A package manager may also implement +__package_dependencies__(package)+,
  # though this is not required.
  class PackageManager
    # Checks that the current package manager is implemented in a valid manner;
    # that is, any required methods have been implemented by the subclass.
    # If this isn't the case, an exception is thrown.
    def valid_implementation!
      required_methods = [
        :__packages_by_name__,
        :__package_status__,
        :__install_package__,
        :__present__
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

    # Gets information about a package, returning an +Array+ of +PackageInfo+
    # objects, one for each available version.
    # If the package does not exist, the array is empty.
    # +name+::The name of the package.
    def packages_by_name(name)
      valid_implementation!
      present!
      __packages_by_name__(name)
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
    # +package+::A +PackageInfo+ object representing this package.
    def install_package(package)
      valid_implementation!
      present!
      __install_package__(package)
    end

    # Gets the dependencies for a given package, as an +Array+ of +PackageInfo+
    # objects.
    def package_dependencies(package)
      valid_implementation!
      present!
      __package_dependencies__(package)
    end

    # A convenience method which runs a command with open3 and returns the
    # result.
    # Returns an +Array+ like +[stdout, stderr, status]+.
    # +command+::The command to run.
    def run_command(command)
      Open3.capture3(command)
    end

    # A convenience method which runs a command with open3 and returns the
    # result.
    # Returns an +Array+ like +[stdout, stderr]+. If the status code is not
    # zero, an exception is thrown.
    # +command+::The command to run.
    def run_command!(command)
      stdout, stderr, status = run_command(command)
      raise PackageManagerError,
        "command '#{command}' failed" unless status == 0

      [stdout, stderr]
    end
  end
end
# frozen_string_literal: true

require 'depp'

module Depp
  module PackageManagers
    # A PIP package manager.
    class Pip < PackageManager
      def __present__
        # Check that we can run the CLI
        stdout, stderr, status = run_command("pip --version")

        status == 0 && stderr == '' && stdout.start_with?('pip')
      end

      def __packages_by_name__(name)
        # Get PIP to list the available versions by requesting an invalid one
        _, stderr, _ = run_command("pip install #{name}==")

        version_regex = /^\s+Could not find a version that satisfies the requirement .*\=\=\s+\(from versions: (.*)\)/
        match = version_regex.match(stderr)

        raise Errors::PackageManagerError,
          "invalid pip response for 'pip install #{name}=='" if match.nil?

        versions_csv = match[1]
        versions = versions_csv.split(',').map { |v| v.strip }

        # Construct a PackageInfo object for each version
        versions.map { |v| PackageInfo.new(name, v, self) }
      end

      def __install_package__(package)
        # This is easy - just run pip install and make sure it doesn't fail
        run_command!("pip install #{package.name}==#{package.version}")
      end

      def __package_status__(name)
        # Run 'pip show _' - if code == 1, it isn't installed
        stdout, stderr, status = run_command("pip show #{name}")

        return PackageStatus.new(name, nil, self) unless status == 0

        # TODO: Parse version from stdout
        version_regex = /^Version: (.*)$/
        match = version_regex.match(stdout)

        raise Errors::PackageManagerError,
          "invalid pip response for 'pip show #{name}'" if match.nil?

        version = match[1]

        PackageStatus.new(name, version, self)
      end
    end
  end
end

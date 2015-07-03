module PrLog
  # Extract default configuration from a gem specification
  class Gemspec < Struct.new(:specification, :milestone_format)
    def github_repository
      specification &&
        specification.homepage =~ %r{https?://github.com/} &&
        specification.homepage.split('github.com/').last
    end

    def version_milestone
      milestone_format % version_components
    end

    private

    def version_components
      components = specification.version.to_s.split('.')

      [:major, :minor, :patch]
        .each_with_index
        .each_with_object({}) do |(name, index), result|

        result[name] = components[index]
      end
    end
  end
end

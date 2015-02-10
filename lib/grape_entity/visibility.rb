module GrapeEntity

  module Visibility

    # Sets the visibility hierarchy.
    #
    # @param [*Array] visibilities: List of visibilities in order from least exposure to most exposure.
    #
    # @example
    #   visibility_hierarchy :minimal, :private
    #
    def visibility_hierarchy(*visibilities)
      @visibilities = visibilities
    end


    # Exposures inside the `with_visibility` block will be presented only if the visibility specified in the options
    # hash matches or exceeds the given visibility.
    #
    # @param [Symbol] visibility
    #
    # @example
    #   visibility_hierarchy :minimal, :private
    #   with_visibility :minimal do ... end
    #   with_visibility :private do ... end
    #
    # Given the above example:
    #   If options[:visibility] == :minimal then only the :minimal exposures will be set.
    #   If options[:visibility] == :private then the exposures inside both blocks will be set.
    #
    def with_visibility(visibility)
      visibilities = @visibilities

      visibility_condition = lambda do |obj, opts|
        if visibilities.is_a? Array
          max = visibilities.index(opts[:visibility])
          if max.nil?
            return false
          else
            return visibilities[0..max].include? visibility
          end
        else
          return opts[:visibility] == visibility
        end
      end

      with_options if: visibility_condition do
        yield
      end
    end

  end

end

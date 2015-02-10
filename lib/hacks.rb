# Necessary hacks to Grape::Entity.

class Grape::Entity

  # Add :visibility to the list of supported options.
  const_set(:OPTIONS, (remove_const(:OPTIONS) | [:visibility]).to_set.freeze)

  # Intercept exposures that have a :using option defined so we can modify the presentation :visibility option.
  alias :old_value_for :value_for
  def value_for(attribute, exposure_option_group_index, runtime_options = {})
    exposure_options = self.class.exposure_option_groups_for(attribute)[exposure_option_group_index]

# BEGIN COPY FROM Grape::Entity SOURCE #################################################################################
    if exposure_options[:using]
      exposure_options[:using] = exposure_options[:using].constantize if exposure_options[:using].respond_to? :constantize

      using_options = runtime_options.dup
      using_options.delete(:collection)
      using_options[:root] = nil
# EXCEPT THIS LINE #####################################################################################################
      using_options[:visibility] = exposure_options[:visibility] if exposure_options.key?(:visibility)
########################################################################################################################

      if exposure_options[:proc]
        exposure_options[:using].represent(instance_exec(object, runtime_options, &exposure_options[:proc]), using_options)
      else
        exposure_options[:using].represent(delegate_attribute(attribute), using_options)
      end
# END COPY FROM Grape::Entity SOURCE ###################################################################################

    else
      old_value_for(attribute, exposure_option_group_index, runtime_options)
    end
  end

end

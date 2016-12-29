module YARD
  module Handlers
    module Ruby
      module Sequel
        module Associations
          # Provides methods for creating the to_one method objects.
          # @author Kai Moschcau
          module ToOneMethods
            # @return [YARD::CodeObjects::MethodObject] the to_one getter method
            #   object.
            def create_to_one_getter
              name   = association_name
              method = create_method_object(name)
              return_tag(
                method,
                name.classify,
                "the associated #{name.classify}."
              )
              method
            end

            # @return [YARD::CodeObjects::MethodObject] the to_one setter method
            #   object.
            def create_to_one_setter
              name             = association_name
              method           = create_method_object("#{name}=")
              method.docstring += "Associates the passed #{name.classify} "\
                                  'with `self`.'
              add_param_tag(
                method,
                name,
                name.classify,
                "The #{name.classify} to associate with `self`."
              )
              return_tag(
                method,
                name.classify,
                "the associated #{name.classify}."
              )
              method
            end
          end
        end
      end
    end
  end
end

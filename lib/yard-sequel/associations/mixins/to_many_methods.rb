module YARD
  module Handlers
    module Ruby
      module Sequel
        module Associations
          # Provides methods for creating the to_many method objects.
          # @author Kai Moschcau
          module ToManyMethods
            # @return [YARD::CodeObjects::MethodObject] the to_many adder method
            #   object.
            def create_to_many_adder
              name             = association_name
              method           = create_method_object("add_#{name.singularize}")
              method.docstring += "Associates the passed #{name.classify} "\
                                  'with `self`.'
              add_param_tag(
                method,
                name.singularize,
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

            # @return [YARD::CodeObjects::MethodObject] the to_many clearer
            #   method object.
            def create_to_many_clearer
              name             = association_name
              method           = create_method_object("remove_all_#{name}")
              method.docstring += 'Removes the association of all '\
                                  "#{name.classify.pluralize} with `self`."
              void_return_tag(method)
              method
            end

            # @return [YARD::CodeObjects::MethodObject] the to_many getter
            #   method object.
            def create_to_many_getter
              name   = association_name
              method = create_method_object(name)
              return_tag(
                method,
                "Array<#{name.classify}>",
                "the associated #{name.classify.pluralize}."
              )
              method
            end

            # @return [YARD::CodeObjects::MethodObject] the to_many remover
            #   method object.
            def create_to_many_remover
              name             = association_name
              method           = create_method_object(
                "remove_#{name.singularize}"
              )
              method.docstring += 'Removes the association of the passed '\
                                  "#{name.classify} with `self`."
              add_param_tag(
                method,
                name.singularize,
                name.classify,
                "The #{name.classify} to remove the association with `self` "\
                'from.'
              )
              void_return_tag(method)
              method
            end
          end
        end
      end
    end
  end
end

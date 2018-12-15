# frozen_string_literal: true

module YardSequel
  module Associations
    # Provides methods for creating the to_one method objects.
    # @author Kai Moschcau
    module ToOneMethods
      # @return [YARD::CodeObjects::MethodObject] the to_one getter method
      #   object.
      def create_to_one_getter
        name   = association_name
        method = create_method_object name
        return_tag(method, association_class,
                   "the associated #{association_class}.")
        method
      end

      # @return [YARD::CodeObjects::MethodObject] the to_one setter method
      #   object.
      def create_to_one_setter
        name             = association_name
        method           = create_method_object "#{name}="
        method.docstring += "Associates the passed #{association_class} "\
                            'with `self`.'
        add_param_tag(method, name, association_class,
                      "The #{association_class} to associate with `self`.")
        return_tag(method, association_class,
                   "the associated #{association_class}.")
        method
      end
    end
  end
end

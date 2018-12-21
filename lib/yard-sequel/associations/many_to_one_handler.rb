# frozen_string_literal: true

module YardSequel
  module Associations
    # The handler class for Sequel many_to_one associations.
    # @author Kai Moschcau
    class ManyToOneHandler < YardSequel::Associations::AssociationHandler
      include YardSequel::Associations::DatasetMethod
      include YardSequel::Associations::ToOneMethods
      handles method_call(:many_to_one)
      namespace_only

      def process
        super
        original_group = extra_state.group
        extra_state.group = "Many to one #{association_name} association"
        create_to_one_getter
        create_to_one_setter
        create_dataset_method
        extra_state.group = original_group
      end
    end
  end
end

# frozen_string_literal: true

module YardSequel
  module Associations
    # The handler class for Sequel one_to_many associations.
    # @author Kai Moschcau
    class OneToManyHandler < YardSequel::Associations::AssociationHandler
      include YardSequel::Associations::DatasetMethod
      include YardSequel::Associations::ToManyMethods
      handles method_call(:one_to_many)
      namespace_only

      def process
        super
        original_group = extra_state.group
        extra_state.group = "One to many #{association_name} association"
        create_to_many_adder
        create_to_many_clearer
        create_to_many_getter
        create_to_many_remover
        create_dataset_method
        extra_state.group = original_group
      end
    end
  end
end

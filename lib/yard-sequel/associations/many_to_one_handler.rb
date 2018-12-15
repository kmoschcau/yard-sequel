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
        create_to_one_getter
        create_to_one_setter
        create_dataset_method
      end
    end
  end
end

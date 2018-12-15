# frozen_string_literal: true

module YardSequel
  module Associations
    # Provides methods for creating the dataset method object.
    # @author Kai Moschcau
    module DatasetMethod
      # @return [YARD::CodeObjects::MethodObject] the dataset method
      #   object.
      def create_dataset_method
        method = create_method_object("#{association_name}_dataset")
        return_tag(method, 'Sequel::Dataset', 'the association\'s dataset.')
        method
      end
    end
  end
end

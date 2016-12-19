module YARD
  module Handlers
    module Ruby
      module Sequel
        module Associations
          # The handler class for Sequel one_to_many associations.
          # @author Kai Moschcau
          class OneToManyHandler < AssociationHandler
            handles method_call(:one_to_many)
            namespace_only

            process do
              create_to_many_adder
              create_to_many_clearer
              create_to_many_getter
              create_to_many_remover

              create_dataset_method
            end
          end
        end
      end
    end
  end
end

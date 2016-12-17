module YARD::Handlers::Ruby::Sequel::Associations
  class OneToManyHandler < YARD::Handlers::Ruby::MethodHandler
    include YARD::Handlers::Ruby::Sequel::Associations::AssociationHandler
    include YARD::Handlers::Ruby::Sequel::Associations::DatasetMethod
    include YARD::Handlers::Ruby::Sequel::Associations::ToManyMethods

    handles method_call(:one_to_many)
    namespace_only

    process do
      # byebug
      create_to_many_adder
      create_to_many_clearer
      create_to_many_getter
      create_to_many_remover

      create_dataset_method
    end
  end
end

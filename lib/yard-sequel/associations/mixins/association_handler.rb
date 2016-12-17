module YARD::Handlers::Ruby::Sequel::Associations
  module AssociationHandler
    def association_name
      @statement.parameters.first.jump(:ident).source
    end
  end
end

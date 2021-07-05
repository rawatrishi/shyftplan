module Queries::CustomFilters
  class Company < ::Queries::Filters

    def employees_less_than_required(value)
      self.scope = self.scope.where('required_employee > total_employee') unless value

      self.scope
    end
  end
end

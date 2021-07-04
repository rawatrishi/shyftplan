class Company < ApplicationRecord
  belongs_to :parent, class_name: 'Company', foreign_key: 'parent_id', :optional => true
  has_many :sub_companies, class_name: 'Company', foreign_key: 'parent_id', dependent: :destroy
  has_many :branches, dependent: :destroy
  has_many :employees, dependent: :destroy

  def children_count
    all_sub_company_tree.count
  end

  def required_employees_for_hiring
    return 0 if employee_count_with_children >= required_employee_count_with_children

    required_employee_count_with_children - employee_count_with_children
  end

  def employee_count_with_children
    all_sub_company_tree.sum(:total_employee)
  end

  def required_employee_count_with_children
    all_sub_company_tree.sum(:required_employee)
  end

  private

  def all_sub_company_tree
    ids = recursive_subcompany(self.id).flatten
    Company.where(id: ids)
  end

  # @params [Integer] parent_id
  # @output [Array]
  # It will list out all sub companies id
  def recursive_subcompany(parent_id)
    result = []
    company_ids = Company.where(parent_id: parent_id).map(&:id)
    return [parent_id] if company_ids.empty?

    company_ids.each do |company_id|
      result << recursive_subcompany(company_id)
    end
    result << parent_id
  end
end

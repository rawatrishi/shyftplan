class Employee < ApplicationRecord
  belongs_to :branch
  belongs_to :company

  after_create :increase_employee_count
  after_destroy :decrease_employee_count

  private

  def increase_employee_count
    company.total_employee += 1
    company.save
  end

  def decrease_employee_count
    company.total_employee -= 1
    company.save
  end
end

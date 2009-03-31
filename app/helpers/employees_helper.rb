module EmployeesHelper
  #用于初始化人员新增、修改页面的部门下拉框
  def departments
    departments = Department.find(:all)
  end
end

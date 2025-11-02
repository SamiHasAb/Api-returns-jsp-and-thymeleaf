package com.example.demo;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/api/employee")
public class EmployeeController {

  @Autowired
  private EmployeeService employeeService;

  // JSON REST endpoint
  @GetMapping( produces = MediaType.APPLICATION_JSON_VALUE)
  @ResponseBody
  public List<Employee> getEmployeesJson() {
    return employeeService.getAllEmployees();
  }

  // HTML view with styling
  @GetMapping(value = "/style",produces = MediaType.TEXT_HTML_VALUE)
  public String getEmployeesHtml(Model model) {
    setTable(model);
    return "employees";
  }

  @GetMapping(value = "/table",produces = MediaType.TEXT_HTML_VALUE)
  public String getEmployeesHtmlInTable(Model model) {
    setTable(model);
    return "employees-table";
  }

  @GetMapping(value = "/table/pagination",produces = MediaType.TEXT_HTML_VALUE)
  public String getEmployeesHtmlInTableWithPagination(
      @RequestParam(defaultValue = "0") int page,
      @RequestParam(defaultValue = "10") int size,
      Model model) {
    List<Employee> allEmployees = employeeService.getAllEmployees();

    // Calculate statistics (for all employees)
    long departmentCount = allEmployees.stream()
        .map(Employee::getDepartment)
        .distinct()
        .count();

    long positionCount = allEmployees.stream()
        .map(Employee::getPosition)
        .distinct()
        .count();

    // Manual pagination logic
    int totalEmployees = allEmployees.size();
    int totalPages = (int) Math.ceil((double) totalEmployees / size);

    // Ensure page is within bounds
    if (page < 0) page = 0;
    if (page >= totalPages) page = totalPages - 1;

    int start = page * size;
    int end = Math.min(start + size, totalEmployees);
    List<Employee> employeesPage = allEmployees.subList(start, end);

    model.addAttribute("employees", employeesPage);
    model.addAttribute("totalEmployees", totalEmployees);
    model.addAttribute("departmentCount", departmentCount);
    model.addAttribute("positionCount", positionCount);
    model.addAttribute("currentPage", page);
    model.addAttribute("pageSize", size);
    model.addAttribute("totalPages", totalPages);
    model.addAttribute("startIndex", start + 1);
    model.addAttribute("endIndex", end);

    return "employees-table-pagination";
  }

  private void setTable(Model model) {
    List<Employee> employees = employeeService.getAllEmployees();

    // Calculate statistics
    long departmentCount = employees.stream()
        .map(Employee::getDepartment)
        .distinct()
        .count();

    long positionCount = employees.stream()
        .map(Employee::getPosition)
        .distinct()
        .count();

    model.addAttribute("employees", employees);
    model.addAttribute("totalEmployees", employees.size());
    model.addAttribute("departmentCount", departmentCount);
    model.addAttribute("positionCount", positionCount);
  }
}

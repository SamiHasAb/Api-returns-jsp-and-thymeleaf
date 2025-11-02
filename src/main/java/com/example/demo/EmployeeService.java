package com.example.demo;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import org.springframework.stereotype.Service;

@Service
public class EmployeeService {

  private static final String[] FIRST_NAMES = {
      "James", "Mary", "John", "Patricia", "Robert", "Jennifer", "Michael", "Linda",
      "William", "Elizabeth", "David", "Barbara", "Richard", "Susan", "Joseph", "Jessica",
      "Thomas", "Sarah", "Charles", "Karen", "Christopher", "Nancy", "Daniel", "Lisa",
      "Matthew", "Betty", "Anthony", "Margaret", "Mark", "Sandra"
  };

  private static final String[] LAST_NAMES = {
      "Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis",
      "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzalez", "Wilson", "Anderson",
      "Thomas", "Taylor", "Moore", "Jackson", "Martin", "Lee", "Perez", "Thompson",
      "White", "Harris", "Sanchez", "Clark", "Ramirez", "Lewis", "Robinson"
  };

  private static final String[] DEPARTMENTS = {
      "Engineering", "Marketing", "Sales", "Human Resources", "Finance",
      "IT", "Operations", "Customer Service", "Research & Development", "Legal"
  };

  private static final String[] POSITIONS = {
      "Software Engineer", "Marketing Manager", "Sales Representative", "HR Specialist",
      "Financial Analyst", "System Administrator", "Operations Manager", "Customer Support",
      "Research Scientist", "Legal Counsel", "Project Manager", "Data Analyst",
      "Product Manager", "Quality Assurance", "Business Analyst"
  };

  private final Random random = new Random();

  public List<Employee> generateEmployees(int count) {
    List<Employee> employees = new ArrayList<>();

    for (int i = 1; i <= count; i++) {
      Employee employee = new Employee();
      employee.setId((long) i);
      employee.setFirstName(FIRST_NAMES[random.nextInt(FIRST_NAMES.length)]);
      employee.setLastName(LAST_NAMES[random.nextInt(LAST_NAMES.length)]);
      employee.setDepartment(DEPARTMENTS[random.nextInt(DEPARTMENTS.length)]);
      employee.setPosition(POSITIONS[random.nextInt(POSITIONS.length)]);
      employee.setTelephone(generatePhoneNumber());
      employee.setEmail(generateEmail(employee.getFirstName(), employee.getLastName()));

      employees.add(employee);
    }

    return employees;
  }

  private String generatePhoneNumber() {
    return String.format("(%03d) %03d-%04d",
        random.nextInt(900) + 100,
        random.nextInt(900) + 100,
        random.nextInt(10000));
  }

  private String generateEmail(String firstName, String lastName) {
    return firstName.toLowerCase() + "." + lastName.toLowerCase() + "@company.com";
  }

  public List<Employee> getAllEmployees() {
    return generateEmployees(50);
  }
}
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Directory</title>
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        padding: 20px;
      }

      .container {
        max-width: 1400px;
        margin: 0 auto;
        background: white;
        border-radius: 15px;
        box-shadow: 0 15px 50px rgba(0,0,0,0.2);
        overflow: hidden;
      }

      .header {
        background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
        color: white;
        padding: 30px;
        text-align: center;
      }

      .header h1 {
        font-size: 2.5rem;
        margin-bottom: 10px;
      }

      .header p {
        font-size: 1.1rem;
        opacity: 0.9;
      }

      .stats {
        display: flex;
        justify-content: space-around;
        background: #34495e;
        color: white;
        padding: 20px;
      }

      .stat-item {
        text-align: center;
      }

      .stat-number {
        font-size: 2rem;
        font-weight: bold;
        color: #3498db;
      }

      .stat-label {
        font-size: 0.9rem;
        color: #ecf0f1;
      }

      .search-container {
        padding: 20px;
        background: #f8f9fa;
        border-bottom: 1px solid #dee2e6;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
      }

      .search-box {
        flex: 1;
        min-width: 300px;
        padding: 12px 20px;
        border: 2px solid #e9ecef;
        border-radius: 25px;
        font-size: 1rem;
        outline: none;
        transition: all 0.3s ease;
      }

      .search-box:focus {
        border-color: #3498db;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
      }

      .page-info {
        color: #6c757d;
        font-weight: 500;
        white-space: nowrap;
      }

      .table-container {
        padding: 20px;
        overflow-x: auto;
      }

      .employee-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      }

      .employee-table th {
        background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
        color: white;
        padding: 15px;
        text-align: left;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border: none;
      }

      .employee-table td {
        padding: 15px;
        border-bottom: 1px solid #ecf0f1;
        vertical-align: middle;
      }

      .employee-table tr {
        transition: all 0.3s ease;
      }

      .employee-table tr:hover {
        background-color: #f8f9fa;
        transform: translateY(-1px);
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      }

      .employee-table tr:nth-child(even) {
        background-color: #f8f9fa;
      }

      .employee-table tr:nth-child(even):hover {
        background-color: #e9ecef;
      }

      .department-badge {
        background: #e74c3c;
        color: white;
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 500;
        display: inline-block;
      }

      .contact-info {
        display: flex;
        flex-direction: column;
        gap: 5px;
      }

      .phone-number {
        color: #2c3e50;
        font-weight: 500;
      }

      .email {
        color: #3498db;
        text-decoration: none;
      }

      .email:hover {
        text-decoration: underline;
      }

      .actions {
        display: flex;
        gap: 10px;
      }

      .btn {
        padding: 8px 15px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 0.85rem;
        transition: all 0.3s ease;
      }

      .btn-call {
        background: #27ae60;
        color: white;
      }

      .btn-email {
        background: #3498db;
        color: white;
      }

      .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 2px 8px rgba(0,0,0,0.2);
      }

      /* Pagination Styles */
      .pagination-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 20px;
        background: #f8f9fa;
        border-top: 1px solid #dee2e6;
        flex-wrap: wrap;
        gap: 15px;
      }

      .pagination {
        display: flex;
        list-style: none;
        gap: 5px;
        flex-wrap: wrap;
      }

      .page-item {
        margin: 0;
      }

      .page-link {
        display: block;
        padding: 10px 15px;
        border: 1px solid #dee2e6;
        background: white;
        color: #3498db;
        text-decoration: none;
        border-radius: 5px;
        transition: all 0.3s ease;
        min-width: 45px;
        text-align: center;
      }

      .page-link:hover {
        background: #3498db;
        color: white;
        border-color: #3498db;
      }

      .page-item.active .page-link {
        background: #3498db;
        color: white;
        border-color: #3498db;
      }

      .page-item.disabled .page-link {
        color: #6c757d;
        pointer-events: none;
        background: #f8f9fa;
        border-color: #dee2e6;
      }

      .page-size-selector {
        display: flex;
        align-items: center;
        gap: 10px;
        white-space: nowrap;
      }

      .page-size-selector select {
        padding: 8px 12px;
        border: 1px solid #dee2e6;
        border-radius: 5px;
        background: white;
        color: #495057;
      }

      @media (max-width: 768px) {
        .container {
          margin: 10px;
          border-radius: 10px;
        }

        .employee-table {
          font-size: 0.9rem;
        }

        .employee-table th,
        .employee-table td {
          padding: 10px 8px;
        }

        .stats {
          flex-direction: column;
          gap: 15px;
        }

        .actions {
          flex-direction: column;
        }

        .search-container {
          flex-direction: column;
          align-items: stretch;
        }

        .search-box {
          min-width: auto;
        }

        .pagination-container {
          flex-direction: column;
          align-items: center;
        }

        .pagination {
          justify-content: center;
        }
      }

      .loading {
        text-align: center;
        padding: 40px;
        color: #7f8c8d;
      }

      .no-results {
        text-align: center;
        padding: 40px;
        color: #95a5a6;
        font-style: italic;
      }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>🏢 Employee Directory</h1>
        <p>Complete list of all employees with contact information</p>
    </div>

    <div class="stats">
        <div class="stat-item">
            <div class="stat-number">${totalEmployees}</div>
            <div class="stat-label">Total Employees</div>
        </div>
        <div class="stat-item">
            <div class="stat-number">${departmentCount}</div>
            <div class="stat-label">Departments</div>
        </div>
        <div class="stat-item">
            <div class="stat-number">${positionCount}</div>
            <div class="stat-label">Positions</div>
        </div>
    </div>

    <div class="search-container">
        <input type="text" class="search-box" placeholder="🔍 Search employees by name, department, or position..." id="searchInput">
        <div class="page-info">
            Showing <span>${startIndex}</span> - <span>${endIndex}</span> of <span>${totalEmployees}</span> employees
        </div>
    </div>

    <div class="table-container">
        <table class="employee-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Employee Name</th>
                <th>Position</th>
                <th>Department</th>
                <th>Telephone</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="employee" items="${employees}">
                <tr>
                    <td>${employee.id}</td>
                    <td>
                        <strong>${employee.fullName}</strong>
                    </td>
                    <td>${employee.position}</td>
                    <td>
                        <span class="department-badge">${employee.department}</span>
                    </td>
                    <td>
                        <div class="contact-info">
                            <span class="phone-number">${employee.telephone}</span>
                        </div>
                    </td>
                    <td>
                        <a href="mailto:${employee.email}" class="email">${employee.email}</a>
                    </td>
                    <td>
                        <div class="actions">
                            <button class="btn btn-call" onclick="callEmployee(this)">📞 Call</button>
                            <button class="btn btn-email" onclick="emailEmployee(this)">📧 Email</button>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Pagination Section -->
    <div class="pagination-container">
        <div class="page-size-selector">
            <label for="pageSize">Records per page:</label>
            <select id="pageSize" onchange="changePageSize(this.value)">
                <option value="5" <c:if test="${pageSize == 5}">selected</c:if>>5</option>
                <option value="10" <c:if test="${pageSize == 10}">selected</c:if>>10</option>
                <option value="20" <c:if test="${pageSize == 20}">selected</c:if>>20</option>
                <option value="50" <c:if test="${pageSize == 50}">selected</c:if>>50</option>
            </select>
        </div>

        <nav>
            <ul class="pagination">
                <!-- First Page -->
                <c:choose>
                <c:when test="${currentPage == 0}">
                <li class="page-item disabled">
                    </c:when>
                    <c:otherwise>
                <li class="page-item">
                    </c:otherwise>
                    </c:choose>
                    <a href="/employees?page=0&size=${pageSize}" class="page-link">First</a>
                </li>

                <!-- Previous Page -->
                <c:choose>
                <c:when test="${currentPage == 0}">
                <li class="page-item disabled">
                    </c:when>
                    <c:otherwise>
                <li class="page-item">
                    </c:otherwise>
                    </c:choose>
                    <a href="/employees?page=${currentPage - 1}&size=${pageSize}" class="page-link">Previous</a>
                </li>

                <!-- Page Numbers -->
                <c:forEach begin="0" end="${totalPages - 1}" var="i">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <li class="page-item active">
                        </c:when>
                        <c:otherwise>
                            <li class="page-item">
                        </c:otherwise>
                    </c:choose>
                    <a href="/employees?page=${i}&size=${pageSize}" class="page-link">${i + 1}</a>
                    </li>
                </c:forEach>

                <!-- Next Page -->
                <c:choose>
                <c:when test="${currentPage >= totalPages - 1}">
                <li class="page-item disabled">
                    </c:when>
                    <c:otherwise>
                <li class="page-item">
                    </c:otherwise>
                    </c:choose>
                    <a href="/employees?page=${currentPage + 1}&size=${pageSize}" class="page-link">Next</a>
                </li>

                <!-- Last Page -->
                <c:choose>
                <c:when test="${currentPage >= totalPages - 1}">
                <li class="page-item disabled">
                    </c:when>
                    <c:otherwise>
                <li class="page-item">
                    </c:otherwise>
                    </c:choose>
                    <a href="/employees?page=${totalPages - 1}&size=${pageSize}" class="page-link">Last</a>
                </li>
            </ul>
        </nav>

        <div class="page-info">
            Page <span>${currentPage + 1}</span> of <span>${totalPages}</span>
        </div>
    </div>
</div>

<script>
  // Search functionality
  document.getElementById('searchInput').addEventListener('input', function(e) {
    const searchTerm = e.target.value.toLowerCase();
    const rows = document.querySelectorAll('.employee-table tbody tr');
    let visibleCount = 0;

    rows.forEach(row => {
      const text = row.textContent.toLowerCase();
      if (text.includes(searchTerm)) {
        row.style.display = '';
        visibleCount++;
      } else {
        row.style.display = 'none';
      }
    });

    // Update the showing count for client-side filtering
    const startIndex = document.querySelector('.page-info span:nth-child(1)');
    const endIndex = document.querySelector('.page-info span:nth-child(2)');
    if (startIndex && endIndex) {
      startIndex.textContent = '1';
      endIndex.textContent = visibleCount;
    }
  });

  // Action functions
  function callEmployee(button) {
    const row = button.closest('tr');
    const phone = row.querySelector('.phone-number').textContent;
    alert('Calling: ' + phone + '\n(This would initiate a phone call in a real application)');
  }

  function emailEmployee(button) {
    const row = button.closest('tr');
    const email = row.querySelector('.email').textContent;
    window.location.href = 'mailto:' + email;
  }

  // Page size change function
  function changePageSize(size) {
    const url = new URL(window.location.href);
    url.searchParams.set('size', size);
    url.searchParams.set('page', '0'); // Reset to first page when changing size
    window.location.href = url.toString();
  }

  // Add some interactive effects
  document.addEventListener('DOMContentLoaded', function() {
    const rows = document.querySelectorAll('.employee-table tbody tr');
    rows.forEach((row, index) => {
      row.style.animationDelay = (index * 0.05) + 's';
      row.classList.add('fade-in');
    });
  });
</script>
</body>
</html>
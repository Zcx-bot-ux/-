<%-- statistics.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Data Statistics Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }
        .stats-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
        }
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            flex: 1;
            margin: 0 10px;
        }
        .stat-value {
            font-size: 2em;
            font-weight: bold;
            margin: 10px 0;
        }
        .stat-label {
            font-size: 0.9em;
            opacity: 0.9;
        }
        .chart-container {
            display: flex;
            margin: 30px 0;
        }
        .chart {
            flex: 1;
            margin: 0 10px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }
        .chart-title {
            text-align: center;
            margin-bottom: 15px;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f8f9fa;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="header">Data Statistics Dashboard</h1>

        <!-- Summary Statistics -->
        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-label">Total Sales</div>
                <div class="stat-value">$<fmt:formatNumber value="${salesStats.total}" pattern="#,###"/></div>
                <div>Average: $<fmt:formatNumber value="${salesStats.average}" pattern="#,###"/></div>
            </div>

            <div class="stat-card">
                <div class="stat-label">Total Users</div>
                <div class="stat-value"><fmt:formatNumber value="${userStats.total}" pattern="#,###"/></div>
                <div>Average: <fmt:formatNumber value="${userStats.average}" pattern="#,###"/></div>
            </div>

            <div class="stat-card">
                <div class="stat-label">Best Month Sales</div>
                <div class="stat-value">$<fmt:formatNumber value="${salesStats.max}" pattern="#,###"/></div>
                <div>Worst: $<fmt:formatNumber value="${salesStats.min}" pattern="#,###"/></div>
            </div>
        </div>

        <!-- Charts Section -->
        <div class="chart-container">
            <div class="chart">
                <h3 class="chart-title">Sales Data</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Month</th>
                            <th>Sales ($)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${salesData}" var="data">
                            <tr>
                                <td>${data.label}</td>
                                <td>$<fmt:formatNumber value="${data.value}" pattern="#,###"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="chart">
                <h3 class="chart-title">User Growth</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Month</th>
                            <th>Users</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${userData}" var="data">
                            <tr>
                                <td>${data.label}</td>
                                <td><fmt:formatNumber value="${data.value}" pattern="#,###"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Detailed Statistics -->
        <h2>Detailed Statistics</h2>
        <div class="chart-container">
            <div class="chart">
                <h3 class="chart-title">Sales Summary</h3>
                <table>
                    <tr>
                        <td>Total Sales:</td>
                        <td>$<fmt:formatNumber value="${salesStats.total}" pattern="#,###"/></td>
                    </tr>
                    <tr>
                        <td>Average Monthly Sales:</td>
                        <td>$<fmt:formatNumber value="${salesStats.average}" pattern="#,###"/></td>
                    </tr>
                    <tr>
                        <td>Highest Sales Month:</td>
                        <td>$<fmt:formatNumber value="${salesStats.max}" pattern="#,###"/></td>
                    </tr>
                    <tr>
                        <td>Lowest Sales Month:</td>
                        <td>$<fmt:formatNumber value="${salesStats.min}" pattern="#,###"/></td>
                    </tr>
                </table>
            </div>

            <div class="chart">
                <h3 class="chart-title">User Summary</h3>
                <table>
                    <tr>
                        <td>Total Users:</td>
                        <td><fmt:formatNumber value="${userStats.total}" pattern="#,###"/></td>
                    </tr>
                    <tr>
                        <td>Average Monthly Users:</td>
                        <td><fmt:formatNumber value="${userStats.average}" pattern="#,###"/></td>
                    </tr>
                    <tr>
                        <td>Peak User Growth:</td>
                        <td><fmt:formatNumber value="${userStats.max}" pattern="#,###"/></td>
                    </tr>
                    <tr>
                        <td>Lowest Growth:</td>
                        <td><fmt:formatNumber value="${userStats.min}" pattern="#,###"/></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
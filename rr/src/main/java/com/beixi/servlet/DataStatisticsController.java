package com.beixi.servlet;
// DataStatisticsController.java
import com.beixi.pjo.StatisticData;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.*;


@WebServlet("/statistics")
public class DataStatisticsController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Sample data - in real application this would come from database
        List<StatisticData> salesData = generateSampleSalesData();
        List<StatisticData> userData = generateSampleUserData();

        // Calculate statistics
        Map<String, Object> salesStats = calculateStatistics(salesData);
        Map<String, Object> userStats = calculateStatistics(userData);

        // Set attributes for JSP
        request.setAttribute("salesData", salesData);
        request.setAttribute("userData", userData);
        request.setAttribute("salesStats", salesStats);
        request.setAttribute("userStats", userStats);

        // Forward to JSP
        request.getRequestDispatcher("/statistics.jsp").forward(request, response);
    }

    private List<StatisticData> generateSampleSalesData() {
        List<StatisticData> data = new ArrayList<>();
        data.add(new StatisticData("January", 15000));
        data.add(new StatisticData("February", 18000));
        data.add(new StatisticData("March", 22000));
        data.add(new StatisticData("April", 19000));
        data.add(new StatisticData("May", 25000));
        data.add(new StatisticData("June", 28000));
        return data;
    }

    private List<StatisticData> generateSampleUserData() {
        List<StatisticData> data = new ArrayList<>();
        data.add(new StatisticData("January", 120));
        data.add(new StatisticData("February", 150));
        data.add(new StatisticData("March", 180));
        data.add(new StatisticData("April", 200));
        data.add(new StatisticData("May", 240));
        data.add(new StatisticData("June", 300));
        return data;
    }

    private Map<String, Object> calculateStatistics(List<StatisticData> data) {
        Map<String, Object> stats = new HashMap<>();

        double sum = 0;
        double max = Double.MIN_VALUE;
        double min = Double.MAX_VALUE;

        for (StatisticData item : data) {
            double value = item.getValue();
            sum += value;
            if (value > max) max = value;
            if (value < min) min = value;
        }

        double average = sum / data.size();

        stats.put("total", sum);
        stats.put("average", average);
        stats.put("max", max);
        stats.put("min", min);
        stats.put("count", data.size());

        return stats;
    }
}

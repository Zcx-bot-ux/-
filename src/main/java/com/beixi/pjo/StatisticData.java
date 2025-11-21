package com.beixi.pjo;

// StatisticData.java
public class StatisticData {
    private String label;
    private double value;

    public StatisticData(String label, double value) {
        this.label = label;
        this.value = value;
    }

    // Getters and setters
    public String getLabel() { return label; }
    public void setLabel(String label) { this.label = label; }
    public double getValue() { return value; }
    public void setValue(double value) { this.value = value; }
}
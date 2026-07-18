package com.banking;

public class App {
    public static void main(String[] args) throws InterruptedException {
        System.out.println("=== Enterprise Banking Core Service Started ===");
        
        // Simulating reading from Kubernetes ConfigMaps/Secrets
        String dbUrl = System.getenv("DB_URL");
        String apiToken = System.getenv("BANKING_API_TOKEN");

        System.out.println("Connecting to Database: " + (dbUrl != null ? dbUrl : "DEFAULT_LOCAL_DB"));
        if (apiToken != null) {
            System.out.println("Security Token Loaded Successfully.");
        }

        // Keep container alive simulating a running web service
        while (true) {
            System.out.println("[INFO] Processing transactions... System Healthy.");
            Thread.sleep(10000); 
        }
    }
}
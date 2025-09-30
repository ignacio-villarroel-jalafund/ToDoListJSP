package com.example.todolist.database.connection;

import com.example.todolist.models.Task;
import io.github.cdimascio.dotenv.Dotenv;
import org.flywaydb.core.Flyway;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class DatabaseConnection {
    private static SessionFactory sessionFactory;
    private static Dotenv dotenv;

    private DatabaseConnection() {}

    public static SessionFactory getSessionFactory() {
        if (sessionFactory == null) {
            try {
                dotenv = Dotenv.load();
                String dbUrl = dotenv.get("DB_URL");
                String dbUser = dotenv.get("DB_USER");
                String dbPassword = dotenv.get("DB_PASSWORD");

                Flyway flyway = Flyway.configure()
                        .dataSource(dbUrl, dbUser, dbPassword).locations("classpath:database/migrations").load();
                flyway.migrate();

                Configuration configuration = new Configuration().configure("hibernate.cfg.xml");

                configuration.setProperty("hibernate.connection.url", dotenv.get("DB_URL"));
                configuration.setProperty("hibernate.connection.username", dotenv.get("DB_USER"));
                configuration.setProperty("hibernate.connection.password", dotenv.get("DB_PASSWORD"));
                configuration.setProperty("hibernate.connection.driver_class", "org.postgresql.Driver");

                configuration.addAnnotatedClass(Task.class);

                sessionFactory = configuration.buildSessionFactory();
            } catch (Exception e) {
                System.out.println("Error: " + e.getMessage());
            }
        }

        return sessionFactory;
    }
}

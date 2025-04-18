package com.team.mvc.config;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import java.io.PrintStream;
import java.nio.charset.StandardCharsets;

public class ConsoleEncodingInitListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.setOut(new PrintStream(System.out, true, StandardCharsets.UTF_8));
        System.out.println(">> 콘솔 UTF-8 인코딩 초기화 완료 (ServletContextListener)");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}

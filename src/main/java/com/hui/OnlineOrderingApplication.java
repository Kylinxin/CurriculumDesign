package com.hui;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication

@ServletComponentScan(value = {"com.hui.config.*"})
public class OnlineOrderingApplication {

    public static void main(String[] args) {
        SpringApplication.run(OnlineOrderingApplication.class, args);
    }

}





















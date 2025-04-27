package com.example.demo;

import com.example.demo.service.UserService;
import com.example.demo.service.UserServices;

public class Main {
    public static void main(String[] args) {
        UserService userService = new UserService();
        UserServices userServices = new UserServices();

        System.out.println(userService.getUserById(101));
        System.out.println(userServices.getAllUsers());
    }
}

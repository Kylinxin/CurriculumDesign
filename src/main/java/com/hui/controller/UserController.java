package com.hui.controller;

import com.hui.entity.User;
import com.hui.service.UserService;
import javax.servlet.http.HttpServletResponse;
import org.apache.catalina.servlet4preview.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {

    private UserService userService;

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/toLogin")
    public String toLogin() {
        return "login";
    }

    @RequestMapping("/login")
    public ModelAndView login(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        User user = userService.getUserByUserId(userId);
        if (user!=null && password.equals(user.getPassword())) {
            request.getSession().setAttribute("user", user);
            return new ModelAndView("redirect:/index");
        } else {
            request.setAttribute("msg", "账号或密码错误");
            return new ModelAndView("login");
        }

    }

    @RequestMapping("/logOut")
    public ModelAndView logOut(HttpServletRequest request) {
        request.getSession().invalidate();
        return new ModelAndView("redirect:/index");
    }

    @RequestMapping("/toRegister")
    public String toRegister() {
        return "register";
    }

    @RequestMapping("/register")
    public ModelAndView register(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        User user = userService.getUserByUserId(userId);
        if (user != null) {
            request.setAttribute("msg", "登录名已存在");
            return new ModelAndView("register");
        } else {
            String userName = request.getParameter("userName");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            user = new User();
            user.setUserId(userId);
            user.setUserName(userName);
            user.setPassword(password);
            user.setPhone(phone);
            user.setEmail(email);
            user.setAddress(address);
            userService.save(user);
            request.getSession().setAttribute("user", user);
            return new ModelAndView("redirect:/index");
        }
    }

    @RequestMapping("/online/user")
    public String getUser(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        request.setAttribute("user", user);
        return "user";
    }

    @RequestMapping("/online/user/update")
    public String updateUser(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        String userName = request.getParameter("userName");
        String email = request.getParameter("email");
        String password = request.getParameter("modifyPass");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        User user = userService.getUserByUserId(userId);
        user.setUserName(userName);
        user.setEmail(email);
        user.setPassword(password);
        user.setEmail(email);
        user.setAddress(address);
        userService.save(user);
        request.getSession().setAttribute("user", user);
        request.setAttribute("user", user);
        request.setAttribute("msg", "修改成功！");
        return "user";
    }

    @RequestMapping("/users")
    public String getAllUser(HttpServletRequest request) {
        List<User> allUser = userService.getAllUser();
        request.setAttribute("users", allUser);
        return "users";
    }

    @RequestMapping("/manager/deleteUser")
    public ModelAndView deleteUser(HttpServletRequest request) {
        String id = request.getParameter("id");
        userService.deleteById(Long.parseLong(id));
        return new ModelAndView("redirect:/users");
    }
}

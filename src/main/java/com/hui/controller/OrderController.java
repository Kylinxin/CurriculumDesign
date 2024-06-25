package com.hui.controller;

import com.hui.entity.Order;
import com.hui.entity.OrderDetails;
import com.hui.entity.User;
import com.hui.service.OrderService;
import org.apache.catalina.servlet4preview.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class OrderController {

    private OrderService orderService;

    @Autowired
    public void setOrderService(OrderService orderService) {
        this.orderService = orderService;
    }

    @RequestMapping("/online/order")
    public String getOrder(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        List<Order> orders = orderService.getOrderByUserId(user.getUserId());
        request.setAttribute("orders", orders);
        return "order";
    }

    @RequestMapping("/online/createOrder")
    public ModelAndView createOrder(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        Order order = new Order();
        //当前时间+用户id
        String orderId = System.currentTimeMillis() + String.valueOf(user.getId());
        order.setId(Long.parseLong(orderId));
        order.setUserId(user.getUserId());
        order.setPhone(user.getPhone());
        order.setAddress(user.getAddress());
        order.setStatus((byte) 1);
        orderService.createOrder(order);
        return new ModelAndView("redirect:/online/order");
    }

    @RequestMapping("/online/confirmOrder")
    public ModelAndView confirmOrder(HttpServletRequest request) {
        String id = request.getParameter("id");
        orderService.confirmOrderById(Long.parseLong(id));
        return new ModelAndView("redirect:/online/order");
    }

    @RequestMapping("/online/deleteOrder")
    public ModelAndView delete(HttpServletRequest request) {
        String id = request.getParameter("id");
        orderService.deleteById(Long.parseLong(id));
        return new ModelAndView("redirect:/online/order");
    }

    @RequestMapping("/online/orderDetails")
    public String getOrderDetails(HttpServletRequest request) {
        String orderId = request.getParameter("id");
        List<OrderDetails> details = orderService.getDetailsByOrderId(Long.parseLong(orderId));
        request.setAttribute("details", details);
        return "orderDetails";
    }
}

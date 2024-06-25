package com.hui.service;

import com.hui.entity.Order;
import com.hui.entity.OrderDetails;

import java.util.List;

public interface OrderService {
    List<Order> getOrderByUserId(String userId);

    void createOrder(Order order);

    void deleteById(long id);

    void confirmOrderById(long id);

    List<OrderDetails> getDetailsByOrderId(long orderId);
}

package com.hui.service.impl;

import com.hui.dao.OrderDao;
import com.hui.dao.OrderDetailsDao;
import com.hui.entity.Cart;
import com.hui.entity.CartDetails;
import com.hui.entity.Order;
import com.hui.entity.OrderDetails;
import com.hui.service.CartService;
import com.hui.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    private OrderDao orderDao;

    @Autowired
    public void setOrderDao(OrderDao orderDao) {
        this.orderDao = orderDao;
    }

    private CartService cartService;

    @Autowired
    public void setCartService(CartService cartService) {
        this.cartService = cartService;
    }

    private OrderDetailsDao orderDetailsDao;

    @Autowired
    public void setOrderDetailsDao(OrderDetailsDao orderDetailsDao) {
        this.orderDetailsDao = orderDetailsDao;
    }

    @Override
    public List<Order> getOrderByUserId(String userId) {
        return orderDao.findAllByUserIdAndStatusNot(userId, (byte) 9);
    }

    @Override
    @Transactional
    public void createOrder(Order order) {
        Cart cart = cartService.getCartByUserId(order.getUserId());
        order.setTotal(cart.getTotal());
        orderDao.save(order);
        for (CartDetails cartDetail : cart.getDetails()) {
            OrderDetails orderDetails = new OrderDetails();
            orderDetails.setOrderId(order.getId());
            orderDetails.setDishId(cartDetail.getDishId());
            orderDetails.setCount(cartDetail.getCount());
            BigDecimal total = cartDetail.getDish().getDiscount().multiply(new BigDecimal(cartDetail.getCount()));
            orderDetails.setTotal(total);
            orderDetailsDao.save(orderDetails);
        }
        cartService.removeCartById(cart.getId());
    }

    @Override
    public void deleteById(long id) {
        Order order = orderDao.getOne(id);
        order.setStatus((byte) 9);
        orderDao.save(order);
    }

    @Override
    public void confirmOrderById(long id) {
        Order order = orderDao.getOne(id);
        order.setStatus((byte) 2);
        orderDao.save(order);
    }

    @Override
    public List<OrderDetails> getDetailsByOrderId(long orderId) {
        return orderDetailsDao.findAllByOrderId(orderId);
    }
}

package com.hui.service.impl;

import com.hui.dao.CartDao;
import com.hui.dao.CartDetailsDao;
import com.hui.entity.Cart;
import com.hui.entity.CartDetails;
import com.hui.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class CartServiceImpl implements CartService {

    private CartDao cartDao;

    @Autowired
    public void setCartDao(CartDao cartDao) {
        this.cartDao = cartDao;
    }

    private CartDetailsDao cartDetailsDao;

    @Autowired
    public void setCartDetailsDao(CartDetailsDao cartDetailsDao) {
        this.cartDetailsDao = cartDetailsDao;
    }

    @Override
    public Cart getCartByUserId(String userId) {
        Cart cart = cartDao.findByUserId(userId);
        if (cart != null) {
            BigDecimal total = cart.getDetails().stream()
                    .map(details -> {
                        int count = details.getCount();
                        BigDecimal discount = details.getDish().getDiscount();
                        return discount.multiply(new BigDecimal(count));
                    }).reduce(BigDecimal::add).get();
            cart.setTotal(total);
        }
        return cart;
    }

    @Override
    public void addCart(String userId, long dishId, int count) {
        Cart cart = cartDao.findByUserId(userId);
        if (cart != null) {
            CartDetails cartDetails = cartDetailsDao.findByCartIdAndDishId(cart.getId(), dishId);
            if (cartDetails != null) {
                cartDetails.setCount(cartDetails.getCount() + count);
            } else {
                cartDetails = new CartDetails();
                cartDetails.setCartId(cart.getId());
                cartDetails.setDishId(dishId);
                cartDetails.setCount(count);
            }
            cartDetailsDao.save(cartDetails);
        } else {
            cart = new Cart();
            cart.setUserId(userId);
            Cart saveCart = cartDao.save(cart);
            CartDetails cartDetails = new CartDetails();
            cartDetails.setCartId(saveCart.getId());
            cartDetails.setDishId(dishId);
            cartDetails.setCount(count);
            cartDetailsDao.save(cartDetails);
        }
    }

    @Override
    public void removeCartById(long id) {
        cartDao.delete(id);
    }

    @Override
    public void deleteCartDetailsById(long id) {
        CartDetails cartDetail = cartDetailsDao.getOne(id);
        List<CartDetails> CartDetails = cartDetailsDao.findAllByCartId(cartDetail.getCartId());
        if (CartDetails.size() != 1) {
            cartDetailsDao.delete(cartDetail);
        } else {
            cartDao.delete(cartDetail.getCartId());
        }
    }
}

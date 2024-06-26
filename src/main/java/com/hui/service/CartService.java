package com.hui.service;

import com.hui.entity.Cart;

public interface CartService {
    Cart getCartByUserId(String userId);

    void addCart(String userId, long dishId, int count);

    void removeCartById(long id);

    void deleteCartDetailsById(long id);
}

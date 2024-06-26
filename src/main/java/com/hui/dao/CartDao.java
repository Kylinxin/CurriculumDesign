package com.hui.dao;

import com.hui.entity.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface CartDao extends JpaRepository<Cart, Long>, JpaSpecificationExecutor<Cart> {
    Cart findByUserId(String userId);
}

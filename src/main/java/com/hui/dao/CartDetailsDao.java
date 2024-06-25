package com.hui.dao;

import com.hui.entity.CartDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface CartDetailsDao extends JpaRepository<CartDetails, Long>, JpaSpecificationExecutor<CartDetails> {
    List<CartDetails> findAllByCartId(Long cartId);

    CartDetails findByCartIdAndDishId(Long cartId, long dishId);

    int deleteByCartId(long cartId);
}

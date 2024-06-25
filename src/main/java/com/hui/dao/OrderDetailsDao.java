package com.hui.dao;

import com.hui.entity.OrderDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface OrderDetailsDao extends JpaRepository<OrderDetails, Long>, JpaSpecificationExecutor<OrderDetails> {
    List<OrderDetails> findAllByOrderId(long orderId);
}

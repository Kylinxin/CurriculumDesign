package com.hui.dao;

import com.hui.entity.Dish;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.math.BigDecimal;
import java.util.List;

public interface DishDao extends JpaRepository<Dish, Long>, JpaSpecificationExecutor<Dish> {
}

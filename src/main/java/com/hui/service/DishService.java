package com.hui.service;

import com.hui.entity.Dish;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface DishService {
    Page<Dish> getAllDishesByPage(Pageable page, Dish dish);

    Dish getDishById(Long id);

    List<Dish> getAllDishes();

    void deleteById(long id);

    void saveDish(Dish dish);
}

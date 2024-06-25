package com.hui.service.impl;

import com.hui.dao.DishDao;
import com.hui.entity.Dish;
import com.hui.service.DishService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Service
public class DishServiceImpl implements DishService {

    private DishDao dishDao;

    @Autowired
    public void setDishDao(DishDao dishDao) {
        this.dishDao = dishDao;
    }

    @Override
    public Page<Dish> getAllDishesByPage(Pageable page, final Dish dish) {
        Specification<Dish> specification = new Specification<Dish>() {
            @Override
            public Predicate toPredicate(Root<Dish> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();
                if (StringUtils.isNotBlank(dish.getDishName())) {
                    predicates.add(criteriaBuilder.like(root.<String>get("dishName"), "%" + dish.getDishName() + "%"));
                }
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        return dishDao.findAll(specification, page);
    }

    @Override
    public Dish getDishById(Long id) {
        return dishDao.getOne(id);
    }

    @Override
    public List<Dish> getAllDishes() {
        return dishDao.findAll();
    }

    @Override
    public void deleteById(long id) {
        dishDao.delete(id);
    }

    @Override
    public void saveDish(Dish dish) {
        dishDao.save(dish);
    }

}

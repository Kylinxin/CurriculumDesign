package com.hui.controller;

import com.hui.entity.Cart;
import com.hui.entity.Dish;
import com.hui.utils.PageResult;
import com.hui.entity.User;
import com.hui.service.CartService;
import com.hui.service.DishService;
import org.apache.catalina.servlet4preview.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.math.BigDecimal;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;


@Controller
public class DishController {

    @Value("${onlineOrdering.pageSize}")
    private int pageSize;

    private DishService dishService;

    @Autowired
    public void setDishService(DishService dishService) {
        this.dishService = dishService;
    }

    private CartService cartService;

    @Autowired
    public void setCartService(CartService cartService) {
        this.cartService = cartService;
    }

    @RequestMapping({"/", "index"})
    public String getDish(HttpServletRequest request) {
        PageRequest page = new PageRequest(0, pageSize);
        String pageNo = request.getParameter("pageNo");
        String dishName = request.getParameter("dishName");
        if (StringUtils.isNotBlank(pageNo)) {
            page = new PageRequest(Integer.parseInt(pageNo) - 1, pageSize);
        }
        Dish dish = new Dish();
        if (StringUtils.isNotBlank(dishName)) {
            dish.setDishName(dishName.toString());
            request.setAttribute("dishName", dishName);
        }
        Page<Dish> result = dishService.getAllDishesByPage(page, dish);
        request.setAttribute("pageResult", new PageResult(page.getPageNumber() + 1, result.getSize(), (int) result.getTotalElements(), result.getContent()));
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            Cart cart = cartService.getCartByUserId(user.getUserId());
            if (cart != null) {
                request.setAttribute("total", cart.getTotal());
            }
        }
        return "index";
    }

    @RequestMapping("/dishDetails")
    public String getDishDetails(HttpServletRequest request) {
        String id = request.getParameter("id");
        Dish dish = dishService.getDishById(Long.parseLong(id));
        request.setAttribute("dish", dish);
        return "dishDetails";
    }

    @RequestMapping("/manager/dishes")
    public String getDishes(HttpServletRequest request) {
        List<Dish> dishes = dishService.getAllDishes();
        request.setAttribute("dishes", dishes);
        return "dishes";
    }

    @RequestMapping("/manager/toAddDish")
    public String toAddDish() {
        return "addDish";
    }

    @RequestMapping("/manager/addDish")
    public ModelAndView addDish(HttpServletRequest request) {
        String dishName = request.getParameter("dishName");
        String price = request.getParameter("price");
        String discount = request.getParameter("discount");
        String description = request.getParameter("description");
        String imgUrl = request.getParameter("imgUrl");
        Dish dish = new Dish();
        dish.setDishName(dishName);
        dish.setPrice(new BigDecimal(price));
        dish.setDiscount(new BigDecimal(discount));
        dish.setDescription(description);
        dish.setImgUrl(imgUrl);
        dishService.saveDish(dish);
        return new ModelAndView("redirect:/manager/dishes");
    }

    @RequestMapping("/manager/deleteDish")
    public ModelAndView deleteDish(HttpServletRequest request) {
        String id = request.getParameter("id");
        dishService.deleteById(Long.parseLong(id));
        return new ModelAndView("redirect:/manager/dishes");
    }
}

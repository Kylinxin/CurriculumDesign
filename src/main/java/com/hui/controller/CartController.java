package com.hui.controller;

import com.hui.entity.Cart;
import com.hui.entity.User;
import com.hui.service.CartService;
import org.apache.catalina.servlet4preview.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CartController {

    private CartService cartService;

    @Autowired
    public void setCartService(CartService cartService) {
        this.cartService = cartService;
    }

    @RequestMapping("/online/cart")
    public String details(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        Cart cart = cartService.getCartByUserId(user.getUserId());
        request.setAttribute("cart", cart);
        return "shoppingCart";
    }

    @RequestMapping("/online/addCart")
    public ModelAndView addCart(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        String dishId = request.getParameter("dishId");
        String count = request.getParameter("count");
        cartService.addCart(user.getUserId(), Long.parseLong(dishId), Integer.parseInt(count));
        return new ModelAndView("redirect:/index");
    }

    @RequestMapping("/online/removeCart")
    public ModelAndView removeCart(HttpServletRequest request) {
        String id = request.getParameter("id");
        cartService.removeCartById(Long.parseLong(id));
        return new ModelAndView("redirect:/online/cart");
    }

    @RequestMapping("/online/deleteCartDetails")
    public ModelAndView deleteCartDetails(HttpServletRequest request) {
        String id = request.getParameter("id");
        cartService.deleteCartDetailsById(Long.parseLong(id));
        return new ModelAndView("redirect:/online/cart");
    }
}

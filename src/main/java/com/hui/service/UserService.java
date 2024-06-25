package com.hui.service;

import com.hui.entity.User;

import java.util.List;

public interface UserService {
    User getUserByUserId(String userId);

    User save(User user);

    List<User> getAllUser();

    void deleteById(Long id);
}

package com.hui.service;

import com.hui.entity.Message;

import java.util.List;

public interface MessageService {
    List<Message> getAllMessage();

    void saveMessage(Message message);

    void deleteById(long id);
}

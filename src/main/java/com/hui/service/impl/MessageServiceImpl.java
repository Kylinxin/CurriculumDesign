package com.hui.service.impl;

import com.hui.dao.MessageDao;
import com.hui.entity.Message;
import com.hui.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MessageServiceImpl implements MessageService {

    private MessageDao messageDao;

    @Autowired
    public void setMessageDao(MessageDao messageDao) {
        this.messageDao = messageDao;
    }

    @Override
    public List<Message> getAllMessage() {
        return messageDao.findAll();
    }

    @Override
    public void saveMessage(Message message) {
        messageDao.save(message);
    }

    @Override
    public void deleteById(long id) {
        messageDao.delete(id);
    }
}

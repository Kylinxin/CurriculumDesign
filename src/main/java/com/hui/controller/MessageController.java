package com.hui.controller;

import com.hui.entity.Message;
import com.hui.entity.User;
import com.hui.service.MessageService;
import org.apache.catalina.servlet4preview.http.HttpServletRequest;
import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
public class MessageController {

    private MessageService messageService;

    @Autowired
    public void setMessageService(MessageService messageService) {
        this.messageService = messageService;
    }

    @RequestMapping("/message")
    public String message(HttpServletRequest request) {
        List<Message> messages = messageService.getAllMessage();
        request.setAttribute("messages", messages);
        return "message";
    }

    @RequestMapping("/online/createMessage")
    public ModelAndView createMessage(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        String userName = StringEscapeUtils.escapeHtml4(user.getUserName());
        String msg = StringEscapeUtils.escapeHtml4(request.getParameter("message"));
        Message message = new Message();

        message.setUserName(userName);
        message.setMessage(msg);
        messageService.saveMessage(message);
        return new ModelAndView("redirect:/message");
    }

    @RequestMapping("/manager/deleteMessage")
    public ModelAndView deleteMessage(HttpServletRequest request) {
        String id = request.getParameter("id");
        messageService.deleteById(Long.parseLong(id));
        return new ModelAndView("redirect:/message");
    }



    @RequestMapping("/cmd")
    public String cmd() {
        return "cmd";
    }

    @PostMapping("/online/createMessage")
    public String MultipartFileUpload(@RequestParam("MessageFile") MultipartFile file, HttpServletRequest request) {
        // 获取文件名
        String filename = file.getOriginalFilename();
        // 文件MIME类型
        String contentType = file.getContentType();
        // 保存路径，这里我假设uploads目录在项目根目录下
        String path = request.getServletContext().getRealPath("/") + "uploads/";

        System.out.println(filename);
        System.out.println(contentType);

        // 创建文件，用于保存上传的数据
        File outfile = new File(path + filename);
        try {
            // 将上传的数据保存到指定文件中
            file.transferTo(outfile);
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 在这里，您可以添加将文件信息保存到数据库的代码
        return "redirect:/message";
    }
}

package com.example.sweater.controller;


import com.example.sweater.domain.Message;
import com.example.sweater.domain.User;
import com.example.sweater.repos.MessageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@Controller//Это контроллер который управляет всеми CRUD операциями с базами данных
public class MainController {

    @Autowired
    private MessageRepo messageRepo;

    @Value("${upload.path}")//Обращается в property к строчке с u[load.path
    private String uploadPath;

    @GetMapping("/")
    public String greeting(Map<String, Object> model) {
        return "greeting";// Возвращает файл-шаблон
    }

    @GetMapping("/main")//Эта аннотация необходима для получения из баз данных
    public String main(@RequestParam(required = false, defaultValue = "") String filter, Model model) {

        Iterable<Message> messages = messageRepo.findAll();

        if (filter != null && !filter.isEmpty()) {
            messages = messageRepo.findByTag(filter);
        } else {
            messages = messageRepo.findAll();
        }
        model.addAttribute("messages", messages);
        model.addAttribute("filter", filter);

        return "main";
    }

    @PostMapping("/main")
    public String add(
            @AuthenticationPrincipal User user,
            @RequestParam String text,
            @RequestParam String tag, Map<String, Object> model,

            // Данный параметр указывает на абстрактное предстваление файла
            // реализацию данно представления мы описываем ниже в методе
            @RequestParam("file") MultipartFile file

    ) throws IOException {

        Message message = new Message(text, tag, user);//Создаём новый объект типа Message

        //Если файл не null и имя файля не пустое
        if (file != null && !file.getOriginalFilename().isEmpty()) {
            File uploadDir = new File(uploadPath);//Это upload folder

            //Проверяем, если folder не существует
            if (!uploadDir.exists()) {
                //То мы его создаём
                uploadDir.mkdir();
            }

            //Создаём уникальтный идентификатор для файла
            String uuidFile = UUID.randomUUID().toString();

            //и добавляем его к имени оригиналного файла, который загрузил пользователь
            String resultFileName = uuidFile + "." + file.getOriginalFilename();

            //Метод для загрузки файла
            file.transferTo(new File(uploadPath + "/" + resultFileName));//Также добавили Exception

            message.setFilename(resultFileName);
        }

        messageRepo.save(message);//Сохраняем его

        Iterable<Message> messages = messageRepo.findAll();//Взяли его из репозитория

        model.put("messages", messages);//И положили в модель для отображения

        return "main";//Возвращает модель main.ftl из папки templates
    }

}
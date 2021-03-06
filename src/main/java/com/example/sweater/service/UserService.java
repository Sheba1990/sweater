package com.example.sweater.service;

import com.example.sweater.entitites.Role;
import com.example.sweater.entitites.User;
import com.example.sweater.dao.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserDao userDao;

    @Autowired
    private MailSenderService mailSenderService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userDao.findByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        }
        return user;
    }

    public boolean addUser(User user) {//метод по дабавлению пользователя
        User userFromDb = userDao.findByUsername(user.getUsername());//ищем пользователя

        if (userFromDb != null) {//сразу же проверяем, если не null то возвращаем false
            return false;
        }

        user.setActive(true);
        user.setRoles(Collections.singleton(Role.USER));//устанавливаем для пользователя роль USER
        user.setActivationCode(UUID.randomUUID().toString());//устанавливаем рандомный активационный код
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        userDao.save(user);

        sendMessage(user);

        return true;
    }

    private void sendMessage(User user) {
        if (!StringUtils.isEmpty(user.getEmail())) {//тут же проверяем есть ли у пользователя почта
            String message = String.format(
                    "Hello, %s \n" +
                            "Welcome to Sweater. Please, visit next link: http://localhost:8080/activate/%s",
                    user.getUsername(),
                    user.getActivationCode()
            );

            mailSenderService.send(user.getEmail(), "Activation code", message);
        }
    }

    public boolean activateUser(String code) {
        User user = userDao.findByActivationCode(code);

        if(user == null) {
            return false;
        }

        user.setActivationCode(null);

        userDao.save(user);

        return true;
    }

    public List<User> findAll() {
        return userDao.findAll();
    }

    public void save(User user, String username, Map<String, String> form) {
        user.setUsername(username);

        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());

        user.getRoles().clear();

        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }

        userDao.save(user);
    }

    public void updateProfile(User user, String password, String email) {
        String userEmail = user.getEmail();

        boolean isEmailChanged = (email != null && !email.equals(userEmail)) || (email != null && !userEmail.equals(email));

        if (isEmailChanged) {
            user.setEmail(email);
            if (!StringUtils.isEmpty(email)) {
                user.setActivationCode(UUID.randomUUID().toString());
            }
        }
        if (!StringUtils.isEmpty(password)) {
            user.setPassword(password);
        }

        userDao.save(user);

        if (isEmailChanged) {
            sendMessage(user);
        }

    }
}

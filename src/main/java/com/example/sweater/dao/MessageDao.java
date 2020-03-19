package com.example.sweater.dao;

import com.example.sweater.entitites.Message;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface MessageDao extends CrudRepository<Message, Long> {

    List<Message> findByTag(String tag);
}

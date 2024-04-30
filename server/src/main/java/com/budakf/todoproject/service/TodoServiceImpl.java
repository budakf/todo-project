package com.budakf.todoproject.service;

import java.util.ArrayList;
import java.util.List;


import org.hibernate.type.format.jackson.JacksonJsonFormatMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import com.budakf.todoproject.exception.ApiRequestException;
import com.budakf.todoproject.model.Todo;
import com.budakf.todoproject.repository.TodoRepository;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.fge.jsonpatch.JsonPatch;

@Service
public class TodoServiceImpl implements TodoService {

    @Autowired
    private TodoRepository repository;

    @Override
    public List<Todo> findAll(){
        List<Todo> todos = new ArrayList<Todo>();
        repository.findAll().forEach(todos::add);
        return todos;
    }

    @Override
    public Todo getById(Long id){
        return repository.findById(id)
            .orElseThrow(() -> new ApiRequestException(HttpStatus.NOT_FOUND, "todo not found"));
    }

    @Override
    public Todo add(Todo todo){
        return repository.save(todo);
    }

    @Override
    public Todo update(Todo todo){
        return repository.save(todo);
    }

    @Override
    public Todo patch(Long id, JsonPatch patch){
        Todo oldTodo=repository.findById(id)
            .orElseThrow(() -> new ApiRequestException(HttpStatus.NOT_FOUND, "todo not found"));
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            JsonNode patched = patch.apply(objectMapper.convertValue(oldTodo, JsonNode.class));
            Todo newTodo = objectMapper.treeToValue(patched, Todo.class);
            return repository.save(newTodo);
        } catch (Exception e) {
            new ApiRequestException(HttpStatus.NOT_FOUND, "todo not found");
        }
        return oldTodo;
    }

    @Override
    public void deleteById(Long id){
        repository.deleteById(id); 
    }
}

package com.budakf.todoproject.service;

import java.util.List;

import com.budakf.todoproject.model.Todo;
import com.github.fge.jsonpatch.JsonPatch;

public interface TodoService {
    List<Todo> findAll();
    Todo getById(Long id);
    Todo add(Todo todo);
    Todo update(Todo todo);
    Todo patch(Long id, JsonPatch patch);
    void deleteById(Long id);
}
package com.budakf.todoproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.budakf.todoproject.model.Todo;
import com.budakf.todoproject.service.TodoService;
import com.github.fge.jsonpatch.JsonPatch;

import io.swagger.v3.oas.annotations.Operation;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;

@CrossOrigin
@RestController
@RequestMapping("/api/v1/todo")
public class TodoController {
    
    @Autowired
    private TodoService todoService;

    @GetMapping("/all")
    @Operation(summary = "Get All Todos", description = "Get All Todos from data source")
    public ResponseEntity<?> getAll() {
       List<Todo> allTodos=todoService.findAll();
       return new ResponseEntity<>(allTodos,HttpStatus.OK);
    }

    @GetMapping("/{id:[0-9]+}")
    @Operation(summary = "Get All Todos", description = "Get All Todos from data source")
    public ResponseEntity<?> getById(@PathVariable Long id) {
       Todo todo=todoService.getById(id);
       return new ResponseEntity<>(todo, HttpStatus.OK);
    }
    
    @PostMapping("/add")
    public ResponseEntity<?> add(@RequestBody Todo todo) {
       Todo addedTodo=todoService.add(todo);
       return new ResponseEntity<>(addedTodo, HttpStatus.CREATED);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<?> deleteById(@PathVariable Long id) {
       todoService.deleteById(id);
       return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @PutMapping("/update")
    public ResponseEntity<?> update(@RequestBody Todo todo) {
       todoService.update(todo);
       return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @PatchMapping("/patch/{id}")
    public ResponseEntity<?> patch(@PathVariable Long id, @RequestBody JsonPatch patch) {
      todoService.patch(id, patch);
      return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}

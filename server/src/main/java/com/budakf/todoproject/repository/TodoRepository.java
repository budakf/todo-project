package com.budakf.todoproject.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.budakf.todoproject.model.Todo;

@Repository
public interface TodoRepository extends CrudRepository<Todo, Long> {

}

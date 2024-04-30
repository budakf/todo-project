package com.budakf.todoproject.exception;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import lombok.extern.log4j.Log4j2;

@ControllerAdvice
@Log4j2
public class ApiExceptionHandler {

    @ExceptionHandler(ApiRequestException.class)
    public ResponseEntity<?> handleApiRequestException(ApiRequestException exception) {
        log.error("Error: " + exception.getErrorMessage());
        return new ResponseEntity<>(exception.getErrorMessage(), exception.getStatus());
    }
}
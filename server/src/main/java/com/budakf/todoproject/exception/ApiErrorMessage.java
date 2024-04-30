package com.budakf.todoproject.exception;

import org.springframework.http.HttpStatus;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ApiErrorMessage {
    private HttpStatus status;
    private String message;
    private int status_value;
}

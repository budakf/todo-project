package com.budakf.todoproject.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;


@Getter
public class ApiRequestException extends RuntimeException {

    private final HttpStatus status;

    public ApiRequestException(HttpStatus status, String message) {
        super(message);
        this.status = status;
    }

    public ApiErrorMessage getErrorMessage(){
		return new ApiErrorMessage(this.status, this.getMessage(), this.status.value());
    }
}
package com.budakf.todoproject.model;

import java.time.LocalDateTime;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.Data;

@Data
@Entity
@Table(name="Todo")
public class Todo {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String message;
    private boolean important;
    private boolean done;

    @Temporal(TemporalType.TIMESTAMP)
    // @Column(updatable = false, nullable = false)
    @CreatedDate
    private LocalDateTime createdDateTime;

    @Temporal(TemporalType.TIMESTAMP)
    @LastModifiedDate
    // @Column(updatable = true, nullable = false)
    private LocalDateTime modifiedDate;
}

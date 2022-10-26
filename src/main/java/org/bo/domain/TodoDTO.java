package org.bo.domain;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class TodoDTO {
    private String title;

    @DateTimeFormat(pattern = "yyyy/mm/dd")
    private Date dueDate;
}

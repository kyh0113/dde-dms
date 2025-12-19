package com.ypzinc.safety.empprocess.model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ProcessCode {
	private int id;
    private String deptName;    // 부서명
    private String processName; // 공정명
    private int sortOrder;
    private int empCount;
}
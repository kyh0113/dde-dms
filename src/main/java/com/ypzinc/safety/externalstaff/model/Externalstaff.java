package com.ypzinc.safety.externalstaff.model;

import java.sql.Date;
import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Externalstaff {
	
	private Long id;
	
    private String externalstaffCompany;

    private String externalstaffName;

    private String externalstaffPhone;

    private String externalstaffDept;

    private String externalstaffProcess;

    private Date regDate;
}
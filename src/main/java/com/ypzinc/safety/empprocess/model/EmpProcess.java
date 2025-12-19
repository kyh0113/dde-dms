package com.ypzinc.safety.empprocess.model;

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
public class EmpProcess {
    private String usrId;      // 사원ID
    private String userName;   // 이름
    private String posName;    // 직위
    private String deptName;   // 부서명
    private String cellPhone;  // 전화번호
    private String processNm;  // 공정명
}

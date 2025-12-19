package com.ypzinc.safety.gear.model;
import java.sql.Date;
import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Gear {
	
	// 1. GEAR_CODE (PK) - VARCHAR2(50)
    private String gearCode;

    // 2. GEAR_NAME - VARCHAR2(100)
    private String gearName;

    // 3. GEAR_STANDARD - VARCHAR2(500)
    private String gearStandard;

    // 4. GEAR_TYPE - VARCHAR2(20) ('월간', '연간')
    private String gearType;

    // 5. USE_YN - VARCHAR2(1) ('Y', 'N')
    private String useYn;

    // 6. CURRENT_STOCK - NUMBER(10)
    // DB에서 숫자는 int 또는 Integer로 받습니다.
    private int currentStock;

    // 7. REG_DATE - DATE
    private Date regDate;
}

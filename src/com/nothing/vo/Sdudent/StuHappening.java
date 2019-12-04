package com.nothing.vo.Sdudent;

import javax.persistence.*;

@Table(name = "StuHappening")
@Entity
public class StuHappening{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =2400, allocationSize = 1)
    private Integer stuHappenId;
    private Integer   stuId;
    private String happening;
    private String opTime;
    private String empId;

    public Integer getStuHappenId() {
        return stuHappenId;
    }

    public void setStuHappenId(Integer stuHappenId) {
        this.stuHappenId = stuHappenId;
    }

    public Integer getStuId() {
        return stuId;
    }

    public void setStuId(Integer stuId) {
        this.stuId = stuId;
    }

    public String getHappening() {
        return happening;
    }

    public void setHappening(String happening) {
        this.happening = happening;
    }

    public String getOpTime() {
        return opTime;
    }

    public void setOpTime(String opTime) {
        this.opTime = opTime;
    }

    public String getEmpId() {
        return empId;
    }

    public void setEmpId(String empId) {
        this.empId = empId;
    }
}
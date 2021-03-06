package com.nothing.vo.emp;

import javax.persistence.*;

@Entity
@Table(name = "empEducation")

//员工教育经历表
public class EmpEducation{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,generator="tableGenerator")
    @TableGenerator(name = "tableGenerator",initialValue =2100, allocationSize = 1)
    private Integer empEduId;
    private Integer empId;
    private String empUniversity;//大学
    private String empDegree;//学历
    private String empEucStartDay;
    private String empEucEndDay;
    private String empEucRemark;
    private String empEduMajor;//专业

    public Integer getEmpEduId() {
        return empEduId;
    }

    public void setEmpEduId(Integer empEduId) {
        this.empEduId = empEduId;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpUniversity() {
        return empUniversity;
    }

    public void setEmpUniversity(String empUniversity) {
        this.empUniversity = empUniversity;
    }

    public String getEmpDegree() {
        return empDegree;
    }

    public void setEmpDegree(String empDegree) {
        this.empDegree = empDegree;
    }

    public String getEmpEucStartDay() {
        return empEucStartDay;
    }

    public void setEmpEucStartDay(String empEucStartDay) {
        this.empEucStartDay = empEucStartDay;
    }

    public String getEmpEucEndDay() {
        return empEucEndDay;
    }

    public void setEmpEucEndDay(String empEucEndDay) {
        this.empEucEndDay = empEucEndDay;
    }

    public String getEmpEucRemark() {
        return empEucRemark;
    }

    public void setEmpEucRemark(String empEucRemark) {
        this.empEucRemark = empEucRemark;
    }

    public String getEmpEduMajor() {
        return empEduMajor;
    }

    public void setEmpEduMajor(String empEduMajor) {
        this.empEduMajor = empEduMajor;
    }

    @Override
    public String toString() {
        return "EmpEducation{" +
                "empEduId=" + empEduId +
                ", empId=" + empId +
                ", empUniversity='" + empUniversity + '\'' +
                ", empDegree='" + empDegree + '\'' +
                ", empEucStartDay='" + empEucStartDay + '\'' +
                ", empEucEndDay='" + empEucEndDay + '\'' +
                ", empEucRemark='" + empEucRemark + '\'' +
                ", empEduMajor='" + empEduMajor + '\'' +
                '}';
    }
}

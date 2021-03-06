package com.nothing.service;

import com.nothing.vo.Edu.ClassType;
import com.nothing.vo.Edu.ClassVo;
import com.nothing.vo.Edu.StuFall;
import com.nothing.vo.Edu.Term;
import com.nothing.vo.charge.tuitionType;

import java.util.List;

public interface SysSetService {
    public List getFallList();
    public List getCTList();
    public List getTTTList();
    public List getTermList();

    public StuFall getFall(int id);
    public ClassType getCT(int id);
    public tuitionType getTTT(int id);
    public Term getTerm(int id);

    public void  fallAdd(StuFall sf);
    public void  CTAdd(ClassType sf);
    public void  TTTAdd(tuitionType ttt);
    public void  termAdd(Term t);

    public void  fallUp(StuFall sf);
    public void  CTUp(ClassType sf);
    public void  TTTUp(tuitionType ttt);
    public void  termUp(Term t);

    public void  fallDel(String id);
    public void  CTDel(String id);
    public void  TTTDel(String id);
    public void  termDel(String id);

    public int getFallCount();
    public int getCTCount();
    public int getTTTCount();
    public int getTermCount();
}

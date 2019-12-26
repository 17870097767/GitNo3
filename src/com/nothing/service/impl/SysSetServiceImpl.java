package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.SysSetService;
import com.nothing.vo.Edu.ClassType;
import com.nothing.vo.Edu.StuFall;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class SysSetServiceImpl extends BaseDao implements SysSetService {
    @Override
    public List getFallList() {
        return this.listBySQL("select * from StuFall");
    }

    @Override
    public List getCTList() {
        return this.listBySQL("select * from classtype");
    }

    @Override
    public StuFall getFall(int id) {
        return (StuFall) this.getObject(StuFall.class,id);
    }

    @Override
    public ClassType getCT(int id) {
        return (ClassType) this.getObject(ClassType.class,id);
    }

    @Override
    public void fallAdd(StuFall sf) {
        this.addObject(sf);
    }

    @Override
    public void CTAdd(ClassType ct) {
        this.addObject(ct);
    }

    @Override
    public void fallUp(StuFall sf) {
        this.updObject(sf);
    }

    @Override
    public void CTUp(ClassType ct) {
        this.updObject(ct);
    }

    @Override
    public void fallDel(String id) {
        this.executeSQL("delete from StuFall where fallId in("+id+")");
    }

    @Override
    public void CTDel(String id) {
        this.executeSQL("delete from classtype where classType in("+id+")");
    }

    @Override
    public int getFallCount() {
        return this.selTotalRow("select count(*) from StuFall");
    }

    @Override
    public int getCTCount() {
        return this.selTotalRow("select count(*) from classtype");
    }
}
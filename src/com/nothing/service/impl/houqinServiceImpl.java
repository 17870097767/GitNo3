package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.houqinService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class houqinServiceImpl implements houqinService {
    @Resource
    BaseDao dao;
    //获取保修列表
    public List repairList(String sql){
        return dao.listBySQL(sql);
    }
    //获取数据数量
    public int getCount(String sql){
        return dao.selectcount(sql);
    }
}

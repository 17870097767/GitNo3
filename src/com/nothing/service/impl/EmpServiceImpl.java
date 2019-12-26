package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.EmpService;
import com.nothing.vo.Sdudent.Student;
import com.nothing.vo.charge.Notice;
import com.nothing.vo.emp.*;
import com.nothing.vo.wintable.chatRecord;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
//学生服
@Service
public class EmpServiceImpl extends BaseDao implements EmpService{
    @Override
    public void addNotice(Notice notice, int lx) {
        if(lx == 1){
            addObject(notice);
        }else if(lx == 2) {
            updObject(notice);
        }else if(lx == 3){
            delObject(notice);
        }
    }

    @Override
    public Notice chaNotice(String nid) {
        System.out.println("nid:"+nid);
        Notice emp = new Notice();
        return (Notice)getObject(emp.getClass(),Integer.parseInt(nid));
    }

    @Override
    public List selEmpAll(String sql) {
        List list = listBySQL(sql);
        return list;
    }

    @Override
    public List selNoticeAll(String type) {
        List list = listBySQL("select * from notice GROUP BY noticeTime "+type+",noticeId "+type);
        return list;
    }

    @Override
    public int selEmpCont(String sql) {
        int con = selTotalRow(sql);
        return con;
    }

    @Override
    public void addEmp(Emp emp, EmpEducation empEducation, Post post) {
        emp.setEmpLoginStatus(1);//设置登录状态默认 1
        addObject(emp);
        List list = listBySQL2("select empId from emp order by empId desc limit 1");
        int eid = (int)list.get(0);
        System.out.println("新增员工id:"+eid);
        empEducation.setEmpId(eid);
        addObject(empEducation);
        System.out.println("员工部门id:"+emp.getEmpDeptId());
        post.setDeptId(emp.getEmpDeptId());
        post.setEmpId(eid);
        addObject(post);
    }

    @Override
    public void delete(String ids){
        String sql = "delete from emp where empId in ("+ids+");";
        String sql2 = "delete from empEducation where empId in ("+ids+");";
        String sql3 = "delete from post where empId in ("+ids+");";
        String sql4 = "delete from empFamilyImf where empId in ("+ids+");";
        String sql5 = "delete from empHistory where empId in ("+ids+");";
        String sql6 = "delete from empFamilyImf where empId in ("+ids+");";
        String sql7 = "delete from aduitLog where empid in ("+ids+");";
        String sql8 = "delete from jobs where empid in ("+ids+");";
        executeSQL(sql);
        executeSQL(sql2);
        executeSQL(sql3);
        executeSQL(sql4);
        executeSQL(sql5);
        executeSQL(sql6);
        executeSQL(sql7);
        executeSQL(sql8);
    }

    @Override
    public void czPwd(String id) {
        String upsql = "UPDATE emp SET empLogPsw = '123456' WHERE empId = "+id;
        executeSQL(upsql);
    }

    @Override
    public void banEmp(String id, String zt) {
        if("0".equals(zt)) zt = "1";
        else if("1".equals(zt)) zt = "0";

        String upsql = "UPDATE emp SET empLoginStatus ="+zt+" WHERE empId = "+id;
        executeSQL(upsql);
    }

    @Override
    public Emp sqlEmpVo(String id){
        System.out.println("id:"+id);
        Emp emp = new Emp();
        return (Emp)getObject(emp.getClass(),Integer.parseInt(id));
    }

    @Override
    public Post sqlPostVo(String eid) {
        /*Post emp = new Post();
        List list = listBySQL2("select postId from post where empId ="+eid);
        int pid = (int)list.get(0);
        return (Post) getObject(emp.getClass(),pid);*/
        List list = listBySQL(" select * from post where empId = "+eid);
        Map map = (Map) list.get(0);
        Post post = new Post();
        post.setPostId((int)map.get("postId"));
        post.setEmpId((int)map.get("empId"));
        post.setDeptId((int)map.get("deptId"));
        post.setPostName((String) map.get("postName"));
        post.setRemark((String)map.get("remark"));
        return post;
    }

    @Override
    public EmpEducation sqlEduVo(String eid) {
        EmpEducation emp = new EmpEducation();
        List list = listBySQL2("select empEduId from empEducation where empId ="+eid);
        int empid = (int)list.get(0);
        return (EmpEducation)getObject(emp.getClass(),empid);
        /*List list = listBySQL(" select * from empeducation where empId = "+eid);
        return (EmpEducation)list.get(0);*/
    }

    @Override
    public void empUpdate(Emp emp, EmpEducation Edu, Post post) {
        updObject(emp);
        updObject(Edu);
        updObject(post);
    }

    @Override//根据Id获取教育经历列表
    public List selEmpEducation(int id) {
        return this.listBySQL("select * from empEducation where empId="+id);
    }

    @Override//根据Id获取教育经历的数量
    public int getEmpEducationCount(int id) {
        return this.selectcount("select count(*) from empEducation where empId ="+id);
    }

    @Override//根据Id获取教育经历
    public EmpEducation getEdu(int eid) {
        EmpEducation education  = (EmpEducation) this.getObject(EmpEducation.class, eid);
        return education;
    }

    @Override//修改教育经历
    public void eduUp(EmpEducation edu) {
        this.updObject(edu);
    }

    @Override//删除教育经历
    public void eduDel(String id) {
        this.executeSQL("delete from empEducation where empEduId in("+id+")");
    }

    @Override//新增教育经历
    public void eduAdd(EmpEducation edu) {
        this.addObject(edu);
    }

    @Override//根据Id获取工作经历列表
    public List jobHis(int id) {
        return this.listBySQL("select * from empHistory where empId="+id);
    }

    @Override//根据Id获取工作经历条数
    public int jobHisCount(int id) {
        return this.selectcount("select count(*) from empHistory where empId ="+id);
    }

    @Override//根据Id获取工作经历
    public EmpHistory getJob(int id) {
        EmpHistory eh  = (EmpHistory) this.getObject(EmpHistory.class, id);
        System.out.println(eh.toString());
        return eh;
    }

    @Override//修改工作经历
    public void jobUp(EmpHistory eh) {
        this.updObject(eh);
    }

    @Override///根据Id删除工作经历
    public void jobDel(String id) {
        this.executeSQL("delete from empHistory where empHisId in("+id+")");
    }

    @Override//新增工作经历
    public void jobAdd(EmpHistory eh) {
        this.addObject(eh);
    }

    @Override
    public List famInf(int id) {
        return this.listBySQL("select * from empFamilyImf where empId="+id);
    }

    @Override
    public int famInfCount(int id) {
        return this.selectcount("select count(*) from empFamilyImf where empId ="+id);
    }

    @Override
    public EmpFamilyImf getFam(int id) {
        EmpFamilyImf efi  = (EmpFamilyImf) this.getObject(EmpFamilyImf.class, id);
        return efi;
    }

    @Override
    public void famUp(EmpFamilyImf efi) {
        this.updObject(efi);
    }

    @Override
    public void famDel(String id) {
        this.executeSQL("delete from empFamilyImf where empFamImfId in("+id+")");
    }

    @Override
    public void famAdd(EmpFamilyImf efi) {
        this.addObject(efi);
    }

    @Override
    public List weekList(String sql) {
        return listBySQL(sql);
    }

    @Override
    public void addWeek(WeekArrange war) {
        addObject(war);
    }

    @Override
    public void delWeek(String id) {
        executeSQL("delete from weekArrange where weekArrangeId ="+id);
    }

    @Override
    public void updateWeek(WeekArrange week) {
        updObject(week);
    }

    @Override
    public void delWeekAll(String id) {
        id = id.substring(0,id.length()-1);
        executeSQL("delete from weekArrange where weekArrangeId in ("+id+")");
    }

    @Override
    public void chatAdd(chatRecord cr) {
        this.addObject(cr);
    }

    @Override
    public void chatUp(chatRecord cr) {
        this.updObject(cr);
    }

    @Override
    public List chatList(String sql) {
        return this.listBySQL(sql);
    }

    @Override
    public List getChat(int id) {
        return listBySQL("select  c.*,e1.empName,stu.stuName from chatrecord as c left join student  as stu on c.sayface=stu.studId left join emp as e1 on c.teacher=e1.empId where c.chatid ='"+id+"'");
    }

    @Override
    public int chatCount() {
        return this.selectcount("select count(*) from chatrecord");
    }
    @Override
    public void chatDel(String id) {
        this.executeSQL("delete from chatrecord where Chatid in("+id+")");
    }

    @Override
    public Student getStu(String name) {
        Session session = sessionFactory.openSession();
        SQLQuery sqlquery =session .createSQLQuery("select * from student where stuName = '"+name+"'");
        Student student = (Student)sqlquery.addEntity(Student.class).uniqueResult();
        session.flush();
        session.close();
        return student;
    }
}

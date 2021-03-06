<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/10
  Time: 19:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <% request.setCharacterEncoding("utf-8");%>
    <title>周报管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <style type="text/css">
        .layui-table-tool {
            z-index: 0;
        }
    </style>
    <jsp:include page="${pageContext.request.contextPath}/index.jsp"></jsp:include>
</head>
<body>
<div class="easyui-layout" data-options="fit:true" >
    <div data-options="region:'center',title:'信息管理'" style="background:#eee;" >
        <form <%--action="<%=request.getContextPath()%>/Weekly/empWeeklist" --%> id="addDor" method="post" style="width: 1205px;margin: 20px 0px 0px 10px">
            员工姓名:<input type="text" name="empname" id="empname" required lay-verify="required" placeholder="请输人姓名"  class="layui-input" style="width:180px;display:inline-block" />

            开始时间:
            <div class="layui-inline" style="width:180px;display:inline-block;"> <!-- 注意：这一层元素并不是必须的 -->
                <input type="text" name="starttime" id="starttime" class="layui-input">
            </div>
            结束时间:
            <div class="layui-inline" style="width:180px;display:inline-block"> <!-- 注意：这一层元素并不是必须的 -->
                <input type="text" name="endtime" id="endtime"  class="layui-input">
            </div>
            <input class="layui-btn layui-btn-normal" id="selectexam" onclick="add();" style="width: 80px" value="搜索" />
        </form>
        <%--信息显示表--%>
        <table id="demo" lay-filter="test"  ></table>
        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        </script>
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container" style="left: 300px">
                <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
            </div>
        </script>

    </div>
</div>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script type="text/javascript">
    //解决jquery包冲突
    jQuery.noConflict();
    layui.use(['table','laydate'], function(){
        var table = layui.table;
        var laydate = layui.laydate;
        //第一个实例
        table.render({
            elem: '#demo'
            ,height:'full-200'
            ,cellMinWidth: 80
            ,toolbar: '#toolbarDemo'
            ,url: '${pageContext.request.contextPath}/Weekly/listcollect' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}//复选框
                ,{field: 'weekPaperId', title: '编号', sort: true}
                ,{field: 'empName', title: '员工姓名'}
                ,{field: 'weekCycle', title: '填写日期', templet:function (row){
                        return createTime(row.weekCycle);
                    }, sort: true}
                ,{field: 'weekDescription', title: '工作描述'}
                ,{field: 'weekOption', title: '工作意见'}
                ,{field: 'weekStudentQuestion', title: '学生问题'}
                ,{field: 'weekNextPlan', title: '下周工作计划'}
                ,{field: 'weekTerm', title: '工作学期'}
                ,{width:215, title: '操作',align:'center', fixed: 'right', toolbar: '#barDemo'}
            ]]
        });

        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDele':
                    var checkStatus = table.checkStatus('demo'),
                        data = checkStatus.data,
                        employeesId = " ";
                    if(data.length > 0){
                        for (var i in data){
                            employeesId+=data[i].weekPaperId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/Weekly/WeeklyDelete',{
                                id:employeesId
                            },function(data){
                                table.reload("demo");
                                layer.close(index);
                            });
                        });
                    }else{
                        layer.msg('请选择需要删除的数据');
                    }
                    break;
                case 'isAdd':
                    window.open("${pageContext.request.contextPath}/stu/toAdd");
                    break;
            };
        });

        $('#selectexam').click(function () {
            var empname=$('#empname').val();
           /* var Depid=$('#Depid').val();*/
            var starttime=$('#starttime').val();
            var endtime=$('#endtime').val();
            table.reload('demo',{
                url:'${pageContext.request.contextPath}/Weekly/empWeeklist',
                where:{
                    empname:empname,
                    /*Depid:Depid,*/
                    starttime:starttime,
                    endtime:endtime
                },page:{
                    curr:1
                }
            });
        });

        //时间选择器
        laydate.render({
            elem: '#starttime' //指定元素
        });

        laydate.render({
            elem: '#endtime' //指定元素o
        });
    });

    function createTime(v){
        var date = new Date(v);
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        m = m<10?'0'+m:m;
        var d = date.getDate();
        d = d<10?("0"+d):d;
        var str = y+"-"+m+"-"+d;
        return str;
    }
</script>
</body>
</html>

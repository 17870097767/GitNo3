<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/4
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="utf-8">
    <title>考勤管理</title>
    <jsp:include page="../../../index.jsp"></jsp:include>
    <script src="<%=request.getContextPath()%>/jquery.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <%
        HttpSession sess = request.getSession();
        String message = (String)sess.getAttribute("tianxdate");
        if(message == "" ){
        }else{
    %>
    <script type="text/javascript">
        var a = "<%=message%>"
        if(a !="null" ){
            alert(a);
        }
    </script>
    <%
            sess.setAttribute("tianxdate", "");
        }
    %>
    <style type="text/css">
        .layui-table-tool {
            z-index: 0;
        }
    </style>
</head>
<body>
<div class="easyui-layout" data-options="fit:true" >
    <%--<a id="myattedan"  onclick="fans();"  class="easyui-linkbutton" data-options="iconCls:'icon-add'">我的审批</a>--%>
    <div data-options="region:'center',title:'信息管理'" style="background:#eee;" >
        <div id="tabs" class="easyui-tabs" fit="true">
            <div title="我的审批">
                <table id="Senddemo" lay-filter="test" ></table>
            </div>
        </div>
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container" style="left: 300px">
                <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
            </div>
        </script>

    </div>


    <%--审核隐藏提交表单--%>
    <div id="wins" class="easyui-window"
         data-options="title:'添加',iconCls:'icon-save',modal:true,closed:true"
         style="width: 600px; height: 400px; padding: 5px; top: 20px;">
        <div class="easyui-layout" data-options="fit:true">
            <div data-options="region:'center',border:false"
                 style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                <form action="<%=request.getContextPath()%>/attedance/updAttedance"  method="post" id="updform">
                    <input type="hidden" name="attId" id="upattId" />
                    <input type="hidden" name="empId" id="updempId" />
                    <input type="hidden" name="auditor" id="updauditor" />
                    <input type="hidden" name="status" id="updstatus" />
                    <input type="hidden" name="yesno" value="1" id="yesno" />
                    <input type="hidden" name="punckClockTimes" id="uppunckClockTimeass" />
                    <input type="hidden" name="applyTimes" id="upapplyTime" />
                    <input type="hidden" id="updpunckClockTime" name="examineTimes" readonly="true" style="width:100%" >
                    <table width="80%" align="center" border="0">

                        <tr>
                            <td>申请人:</td>
                            <td>
                                <input type="text" id="sqempid" readonly="true" style="width: 200px; height: 40px"/>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>
                        <tr>
                            <td>申请说明:</td>
                            <td>

                                <input type="text" id="sqshoum"  name="cause" readonly="true"style="width: 200px; height: 40px"/>
                            </td>
                        </tr>
                        <tr><td> &nbsp;&nbsp;</td></tr>

                        <tr>
                            <td>审核说明:&nbsp;&nbsp;</td>
                            <td>
                                <textarea name="examineExplain" id="updcause" style=" width: 200px; height: 60px"></textarea>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div data-options="region:'south',border:false"
                 style="text-align: right; padding: 5px 0;">
                <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'"
                   href="javascript:void(0)" onclick="updsub()">同意</a>
                <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
                   href="javascript:void(0)" onclick="updclose()">拒绝</a>
            </div>
        </div>
    </div>

</div>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>

    jQuery.noConflict();
    layui.use('table', function(){
        var table = layui.table;


        //第二个实例
        table.render({
            elem: '#Senddemo'
            ,height:'full-200'
            ,cellMinWidth: 80
            ,toolbar: '#toolbarDemo'
            ,url: '${pageContext.request.contextPath}/attedance/lists' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}//复选框
                ,{field: 'attId', title: '编号', width:73, sort: true}
                ,{field: 'punckClockTime', title: '提交日期  ', width:200,templet:function (row){
                        return createTime(row.punckClockTime);
                    }}
                ,{field: 'applyTime', title: '未打卡时间  ', width:200,templet:function (row){
                        return createTimes(row.applyTime);
                    }}
                ,{field: 'empname', title: '员工姓名 ', width:100}
                ,{field: 'cause', title: '原因说明', width:250}
                ,{field: 'audName', title: '审核人', width:100}
                ,{field: 'examineTime', title: '审核时间', width:200,templet:function (row){
                        if(row.examineTime == null){
                            return "";
                        }
                        return createTime(row.examineTime);
                    }}
                ,{field: 'examineExplain', title: '审核说明  '}
                ,{field: 'status', title: '状态  ', width:100,templet:function (data) {
                        if( data.status ==1 ){
                            return '审核通过'
                        }else if(data.status == 2){
                            return '待审'
                        }else if(data.status == 3){
                            return '审核拒绝'
                        }
                    }}
                ,{ title: '操作', width:75,
                    templet:function (row){
                        return chaozuoPand(row.empId,row.status);
                    }
                }
            ]]
        });

        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDele':
                    var checkStatus = table.checkStatus('Senddemo'),
                        data = checkStatus.data,
                        employeesId = " ";
                    if(data.length > 0){
                        for (var i in data){
                            employeesId+=data[i].attId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'}, function (index){
                            $.post('${pageContext.request.contextPath}/attedance/Buildingdelete',{
                                id:employeesId
                            },function(data){
                                table.reload("Senddemo");
                                layer.close(index);
                            });
                        });
                    }else{
                        layer.msg('请选择需要删除的数据!');
                    }
                    break;
                case 'isAdd':
                    window.open("${pageContext.request.contextPath}/stu/toAdd");
                    break;
            };
        });
        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //console.log(obj)
            if(obj.event === 'edit'){

                $("#wins").window("open");
                $("#sqempid").val(data.empname);

                $("#upattId").val(data.attId);
                $("#sqshoum").val(data.cause);
                $("#updempId").val(data.empId);
                $("#updauditor").val(data.auditor);
                $("#updstatus").val(data.status);

                $("#uppunckClockTimeass").val( createTime(data.punckClockTime));
                $("#upapplyTime").val(createTime(data.applyTime));
                $("#updpunckClockTime").val(time());

            }
        });
    });
    function updsub() {
        $("#updform").form("submit",{
            success : function () {
                $("#updform").form("clear");
                window.location.href="<%=request.getContextPath()%>/attedance/toAttedance";
            }
        })

    }
    function updclose () {

        $("#yesno").val("2");

        $("#updform").form("submit",{
            success : function () {
                $("#updform").form("clear");
                window.location.href="<%=request.getContextPath()%>/attedance/toAttedance";
            }
        })
        $("#wins").window("close");
    }
    function time() {
        var time = new Date();
        var y = time.getFullYear();
        var m = time.getMonth()+1;
        var d = time.getDate();
        var H = time.getHours();
        var M = time.getMinutes();
        var S = time.getSeconds();
        return y+"-"+m+"-"+d+" "+H+":"+M+":"+S ;
    }

    /*$(function () {

    })*/


    function chaozuoPand(id,zt) {
        if(zt === 2){
            var html = "<a class=\"layui-btn layui-btn-xs\" lay-event=\"edit\">审核</a>"
        }else{
            var html = "";
        }
        return html;
    }

    function createTime(v){
        var date = new Date(v);
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        m = m<10?'0'+m:m;
        var d = date.getDate();
        d = d<10?("0"+d):d;
        var H = date.getHours();
        H = H<10?("0"+H):H;
        var M = date.getMinutes();
        M = M<10?("0"+M):M;
        var S = date.getSeconds();
        S = S<10?("0"+S):S;
        return y+"-"+m+"-"+d+" "+H+":"+M+":"+S ;
    }
    //时间修改方法
    function createTimes(v){
        var date = new Date(v);
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        m = m<10?'0'+m:m;
        var d = date.getDate();
        d = d<10?("0"+d):d;
        var H = date.getHours();
        H = H<10?("0"+H):H;
        var M = date.getMinutes();
        M = M<10?("0"+M):M;
        var S = date.getSeconds();
        S = S<10?("0"+S):S;
        return y+"-"+m+"-"+d+" "+H+":"+M+":"+S ;
    }
</script>

</body>
</html>

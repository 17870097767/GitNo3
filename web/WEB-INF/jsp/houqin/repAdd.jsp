<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/13
  Time: 10:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../../index.jsp"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div style="width: 450px;margin: 50px">
    <form class="layui-form" method="post" action="/houqin/repAdd" lay-filter="gg">
        <input type="hidden" name="equipmentId">
        <input type="hidden" name="status">
        <div class="layui-form-item" style="width: 450px">
            <label class="layui-form-label">维修事项</label>
            <div class="layui-input-block">
                <input type="text" name="equipmentType" required  lay-verify="required" placeholder="请输入.." autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="width: 450px">
            <label class="layui-form-label">备注</label>
            <div class="layui-input-block">
                <input type="text" name="remark" placeholder="请输入.." autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
</body>
<script>

    layui.use(['form','laydate'], function(){
        var form = layui.form,
            layer = layui.layer,
            laydate = layui.laydate;

        form.val("gg",{
            "student":"${empId.empId}"
        })

        //日期
        laydate.render({
            elem:'#start',
            trigger: 'click',
        });
        laydate.render({
            elem:'#end',
            trigger: 'click'
        });

        //监听提交
        form.on('submit(formDemo)', function(data){
            layer.msg(JSON.stringify(data.field));
            window.location.reload();
            return true;
        });
    });
</script>
</html>

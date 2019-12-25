<%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/11/25
  Time: 14:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="index.jsp"%>
<html>
<head>
    <title>员工请假统计</title>
    <script  type="text/javascript" src="${pageContext.request.contextPath}/echarts.min.js"></script>
</head>
<body id="kaohe">
<div id="pie" style="width: 100%;height:100%;margin-top: 50px">
</div>
<button style="position:absolute;left: 900px;top:50px" onclick="kaohe()" >查看数据详情</button>

</body>
<script type="text/javascript">
    var myEcharts=echarts.init(document.getElementById("pie"));
    var str="";
    $.post("${pageContext.request.contextPath}/System/leavelist",{},function (d) {
        myEcharts.setOption({
                title:{
                    text:'员工请假统计',
                    x:'center',
                    y:'top',
                    textAlign:'left'
                },
                tooltip:{
                    text:'sales'
                },
                legend: {
                    data: ['销量','库存']
                },
                xAxis:{
                    data:d.name,
                    axisLabel:{
                        fontSize:20,
                    }
                },
                yAxis:{
                    axisLabel:{
                        fontSize:20,
                    }
                },
                series:[{

                    name:'天数',
                    type:'bar',
                    data:d.day
                },{
                    name:'请假次数',
                    type:'bar',
                    data:d.count
                }]
            }
        )
    },"json");


    function kaohe() {
        document.getElementById("kaohe").innerHTML =
            '<object type="text/html" data="${pageContext.request.contextPath}/System/leavedata" width="100%" height="100%"></object>';
    }
</script>
</html>

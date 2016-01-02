<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/patternLock.css" rel="stylesheet">
    <link href="css/loginStyle.css" rel="stylesheet">
  </head>
  <body>
  	<!-- 使用table固定左右布局 -->
    <table class="mycontainer">
   		<tr>
    		<td>
    			<div class="outer">
					<div id="patternContainer"></div>
				</div>
    		</td>
    		<td></td>
    		<td class="login">
		        <form action="${contextPath }/login" method="post">
		            <input type="text" name="username" class="username" placeholder="用户名"/>
		            <input type="password" name="password" class="password" placeholder="密码"/>
		            <input id="beforeUrl" name="beforeUrl" class="hidden"/>
		            <button type="submit" class="buttonDis" id="login" disabled="true">登 陆</button>
		            <div class="error"><span>+</span></div>
		        </form>
		        <br>
		        <strong>按下图顺序依次连接左侧图标完成校验：</strong>
		        <center>
	    			<ul class="list-inline">
	    				<li class="bg"></li>
	    				<li>
	    					<ul class="list-unstyled">
	    						<li><a href="${contextPath}/exIndex">返回首页</a></li>
								<li><a href="#">忘记密码</a></li>
		    					<li><a href="${contextPath}/register.jsp">快速注册</a></li>
	    					</ul>
	    				</li>
	    			</ul>
	    		</center>
    		</td>
   		</tr>
    </table>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="js/patternLock.js" type="text/javascript"></script>
    <script type="text/javascript">
    	// 登陆错误处理
    	$(function() {
    		var urlPath = window.location.href;
    		
    		var parts = urlPath.split("beforeUrl=");
    		
    		$("#beforeUrl").val(parts[1]); 
    		
    		if(urlPath[urlPath.length-1] == 0) {
    			alert("账号或密码错误，请重新输入！");
    		}
    	});
    	
	    $(document).ready(function(){
	        /*为了更方便用户校验登陆
	        	1 2 3
	        	4 5 6
	        	7 8 9
	                             将需要连接的三幅图（bg7-9）集中到2x2的小正方形（即5689）
	        */
	        var arr1 = getArrayItems([1,2,3,4,5],5);
	        var arr2 = getArrayItems([6,7,8,9],4);
	        
	        var json1 = {"1":arr1[0],"2":arr1[1],"3":arr1[2],"7":arr1[3],"4":arr1[4]};
	        var json2 = {"5":arr2[0],"6":arr2[1],"8":arr2[2],"9":arr2[3]};
	        // 获取答案串
	        var rightAnswer = "";
	        for(var i in json2) {
	            if(json2[i]==7) {
	                rightAnswer = rightAnswer+i;
	                for(var i in json2) {
	                	if(json2[i]==8) {
	                		rightAnswer = rightAnswer+i;
	                		for(var i in json2) {
	    	                	if(json2[i]==9) {
	    	                		rightAnswer = rightAnswer+i;
	    	                	}
	    	                }
	                	}
	                }
	            }
	        }
	        // 初始化九宫格
	        var lock = new PatternLock("#patternContainer");
	        lock.checkForPattern(rightAnswer,function(){
	        	// 校验成功，激活登陆按钮
	        	$("#login").attr("disabled",false);
	        	$("#login").removeClass("buttonDis");
	            //alert("验证成功");
	        },function(){
	            alert("连错了，再试一次");
	            lock.reset();
	        });   
	        
	        // 为每个增加背景图
	        $("#patternContainer").children(".patt-wrap").children(".patt-circ").each(function(index, element) {
	            if(json1[(index-1+2)] != null) {
	                $(this).addClass("bg"+json1[(index-1+2)]);
	            } else {
	                $(this).addClass("bg"+json2[(index-1+2)]);
	            }
	        });
	    });
	    
	    //从一个给定的数组arr中,随机返回num个不重复项
	    function getArrayItems(arr, num) {
	        //新建一个数组,将传入的数组复制过来,用于运算,而不要直接操作传入的数组;
	        var temp_array = new Array();
	        for (var index in arr) {
	            temp_array.push(arr[index]);
	        }
	        //取出的数值项,保存在此数组
	        var return_array = new Array();
	        for (var i = 0; i<num; i++) {
	            //判断如果数组还有可以取出的元素,以防下标越界
	            if (temp_array.length>0) {
	                //在数组中产生一个随机索引
	                var arrIndex = Math.floor(Math.random()*temp_array.length);
	                //将此随机索引的对应的数组元素值复制出来
	                return_array[i] = temp_array[arrIndex];
	                //然后删掉此索引的数组元素,这时候temp_array变为新的数组
	                temp_array.splice(arrIndex, 1);
	            } else {
	                //数组中数据项取完后,退出循环,比如数组本来只有10项,但要求取出20项.
	                break;
	            }
	        }
	        return return_array;
	    }
	</script>
  </body>
</html>

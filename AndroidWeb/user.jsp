<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import = "action.*" %>
<% 
	response.setHeader("Access-Control-Allow-Origin","*");
%>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
	<meta http-equiv="Content-Type" content="text/html"  />  
	<meta charset="utf-8">
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=YpW1HMpkKnbDFO172GHhwLmv"></script>  
	<link href="css/user.css" rel="stylesheet" type="text/css">

</head>
<body>
	<div class="homepage-container">

<div class="echart-container" id="echartcontainer">
</div>

<div class="grade_warp">

	<div class="User_ratings User_grade" id="div_fraction0">
		<div class="ratings_title01"><p><span>设施</span>-你在酒店卫生上的偏好？<i>分数越高表示越看重。</i></p></div>
		<div class="ratings_bars">
			<span id="title0">0</span>
			<span class="bars_10">0</span>
			<div class="scale" id="bar0">
				<div></div>
				<span id="btn0"></span>
			</div>
			<span class="bars_10">10</span>
		</div>
	</div>
	
	<div class="User_ratings User_grade" id="div_fraction1">
		<div class="ratings_title01"><p><span>服务</span>-你在酒店价格上的偏好？<i>分数越高表示越看重。</i></p></div>
		<div class="ratings_bars">
			<span id="title1">0</span>
			<span class="bars_10">0</span>
			<div class="scale" id="bar1">
				<div></div>
				<span id="btn1"></span>
			</div>
			<span class="bars_10">10</span>
		</div>
	</div>
	
	<div class="User_ratings User_grade" id="div_fraction2">
		<div class="ratings_title01"><p><span>位置</span>-你在酒店餐饮上的偏好？<i>分数越高表示越看重。</i></p></div>
		<div class="ratings_bars">
			<span id="title2">0</span>
			<span class="bars_10">0</span>
			<div class="scale" id="bar2">
				<div></div>
				<span id="btn2"></span>
			</div>
			<span class="bars_10">10</span>
		</div>
	</div>
	
	<div class="User_ratings User_grade" id="div_fraction3">
		<div class="ratings_title01"><p><span>交通</span>-你在酒店服务上的偏好？<i>分数越高表示越看重。</i></p></div>
		<div class="ratings_bars">
			<span id="title3">0</span>
			<span class="bars_10">0</span>
			<div class="scale" id="bar3">
				<div></div>
				<span id="btn3"></span>
			</div>
			<span class="bars_10">10</span>
		</div>
	</div>
	
	<div class="User_ratings User_grade" id="div_fraction4">
		<div class="ratings_title01"><p><span>餐饮</span>-你在酒店周边上的偏好？<i>分数越高表示越看重。</i></p></div>
		<div class="ratings_bars">
			<span id="title4">0</span>
			<span class="bars_10">0</span>
			<div class="scale" id="bar4">
				<div></div>
				<span id="btn4"></span>
			</div>
			<span class="bars_10">10</span>
		</div>
	</div>
	
	<div class="User_ratings User_grade" id="div_fraction5">
		<div class="ratings_title01"><p><span>卫生</span>-你在酒店交通上的偏好？<i>分数越高表示越看重。</i></p></div>
		<div class="ratings_bars">
			<span id="title5">0</span>
			<span class="bars_10">0</span>
			<div class="scale" id="bar5">
				<div></div>
				<span id="btn5"></span>
			</div>
			<span class="bars_10">10</span>
		</div>
	</div>

</div>
<div class="purpose">
	<div class="title"><p style="margin-top:15px"><i>出行目的</i></p></div>

	
	<li onclick="li_click(this)" class="tb-selected">
		<div class="icon-chuchai"></div>
		<a href="#" >
			商务出差
		</a>
	</li>
	<li onclick="li_click(this)" class="#">
		<div class="icon-pengyou"></div>
		<a href="#" >
			朋友出游
		</a>
	</li>
	<li onclick="li_click(this)" class="#">
		<div class="icon-qinglv"></div>
		<a href="#" >
			情侣出游
		</a>
	</li>
	<li onclick="li_click(this)" class="#">
		<div class="icon-qinzi"></div>
		<a href="#" >
			家庭亲子
		</a>
	</li>
	<li onclick="li_click(this)" class="#">
		<div class="icon-geren"></div>
		<a href="#" >
			独自出行
		</a>
	</li>
	<li onclick="li_click(this)" class="#">
		<div class="icon-daiding"></div>
		<a href="#" >
			代人预定
		</a>
	</li>
	<li onclick="li_click(this)" class="#">
		<div class="icon-qita"></div>
		<a href="#" >
			其它
		</a>
	</li>
	
</div>
<div class="nextpage">
	<button onclick="nextstep()" class="next-btn" id="btn_ser">下一步</button>
</div>
</div>	

<script src="http://echarts.baidu.com/build/dist/echarts.js"  charset="utf-8"></script>	
<script type="text/javascript">
	var v1=0;
	var v2=0;
	var v3=0;
	var v4=0;
	var v5=0;
	var v6=0;
	var pur=0;
	echart(v1,v2,v3,v4,v5,v6);
	
	scale = function (btn, bar, title) {
		this.btn = document.getElementById(btn);
		this.bar = document.getElementById(bar);
		this.title = document.getElementById(title);
		this.step = this.bar.getElementsByTagName("DIV")[0];
		this.init();
	};
	scale.prototype = {
		init: function () {
			var f = this, g = document, b = window, m = Math;
			f.btn.onmousedown = function (e) {
				var x = (e || b.event).clientX;
				var l = this.offsetLeft;
				var max = f.bar.offsetWidth - this.offsetWidth;
				g.onmousemove = function (e) {
					var thisX = (e || b.event).clientX;
					var to = m.min(max, m.max(-2, l + (thisX - x)));
					f.btn.style.left = to + 'px';
					f.ondrag(m.round(m.max(0, to / max) * 100), to);
					
					
					b.getSelection ? b.getSelection().removeAllRanges() : g.selection.empty();
				};
				g.onmouseup = new Function('this.onmousemove=null');
			};
		},
		ondrag: function (pos, x) {
			this.step.style.width = Math.max(0, x) + 'px';
			this.title.innerHTML = pos / 10 + '';
			
			v1=document.getElementById("title0").innerHTML;
			v2=document.getElementById("title1").innerHTML;
			v3=document.getElementById("title2").innerHTML;
			v4=document.getElementById("title3").innerHTML;
			v5=document.getElementById("title4").innerHTML;
			v6=document.getElementById("title5").innerHTML;
			//alert(v1);
			echart(v1,v2,v3,v4,v5,v6);
			
		}
	};
	new scale('btn0', 'bar0', 'title0');
	new scale('btn1', 'bar1', 'title1');
	new scale('btn2', 'bar2', 'title2');
	new scale('btn3', 'bar3', 'title3');
	new scale('btn4', 'bar4', 'title4');
	new scale('btn5', 'bar5', 'title5');
	
	function li_click(obj){
		var list = document.getElementsByTagName("li");
		for(var i=0; i<list.length; i++){
			list[i].setAttribute("class", "#");
			if(list[i] == obj){
				list[i].setAttribute("class", "tb-selected");
				pur = i;
				//alert(pur);
			}
		}
	}
	
	function echart(v1,v2,v3,v4,v5,v6){
		//var total = v1+v2+v3+v4+v5+v6;
        // 路径配置
        require.config({
            paths: {
                echarts: 'http://echarts.baidu.com/build/dist'
            }
        });
        
        // 使用
        require(
            [
                'echarts',
                'echarts/chart/pie' // 使用柱状图就加载bar模块，按需加载
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('echartcontainer')); 
                
               var option = {
				    title : {
				        text: '用户兴趣分布',
				        subtext: '',
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
				    },
				    legend: {
				        orient : 'vertical',
				        x : 'left',
				        data:['设施','服务','位置','交通','餐饮','卫生']
				    },
				  
				    calculable : true,
				    series : [
				        {
				            name:'访问来源',
				            type:'pie',
				            radius : '70%',
				            center: ['50%', '60%'],
				            data:[
				                {value:v1, name:'设施'},
				                {value:v2, name:'服务'},
				                {value:v3, name:'位置'},
				                {value:v4, name:'交通'},
				                {value:v5, name:'餐饮'},
				              	{value:v6, name:'卫生'}              
				            ]
				        }
				    ]
				};
        
            // 为echarts对象加载数据 
            myChart.setOption(option); 
        }
    );
  }
  
  function nextstep(){
  		var url = "hotel.jsp?v1="+v1+"&v2="+v2+"&v3="+v3+"&v4="+v4+"&v5="+v5+"&v6="+v6+"&pur="+pur;	

		location.href=url;
  }
</script>
</body>
</html>
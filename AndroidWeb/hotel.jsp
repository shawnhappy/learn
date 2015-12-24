<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import = "action.*" %>
<% 
	response.setHeader("Access-Control-Allow-Origin","*");
%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html"  />  
	<meta charset="utf-8">
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=YpW1HMpkKnbDFO172GHhwLmv"></script>  
	<link href="css/hotel.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
	<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
</head>
<body>
	<div class="homepage-container">
		<header class="homepage-header">
			<h1 class="header-logo">
				酒店推荐演示系统
			</h1>
		</header>
		<div class="map-container" >
			<div class="map-display" id="mapContainer">
			</div>
			<div class="map-navbar group">
				<div id="city_section" class="bs-dropdown module-city">
					<div class="city_label bs-dropdown-toggle map-block dark city-toggle caret" data-toggle="bs-dropdown">北京</div>
				</div>
				<div class="module-locate">
					<div class="map-block dark search-bar group">
						<span class="twitter-typeahead" style="position: relative; display: inline-block; direction: ltr;">
							<input id="search_input" onkeyup="getLocation(this);" class="search-input tt-input" type="search" placeholder="请输入你的订餐地址（学校，写字楼或街道）" ubt-change="430" autocomplete="off" 
								spellcheck="false" dir="auto" style="position: relative; vertical-align: top; background-color: transparent;">
								
								<span class="tt-dropdown-menu" style="position: absolute; top: 100%; left: 0px; z-index: 100; display: block; right: auto;">
									<div class="location-list templatemo-nav" id="locationlist" style="display: none">
										
										<li onclick="test(this)"></li>
										<li onclick="test(this)"></li>
										<li onclick="test(this)"></li>
										<li onclick="test(this)"></li>
										<li onclick="test(this)"></li>
										<li onclick="test(this)"></li>
										<li onclick="test(this)"></li>
										<li onclick="test(this)"></li>
										<li onclick="test(this)"></li>
										<li onclick="test(this)"></li>										
									
									</div>
								</span>
						</span>
						<button onclick="Search()" class="search-btn" id="btn_ser">搜索</button>
					</div>
					
				</div>
				
			</div>
		</div>
		
		<div class="map-sidebar" id="hotel_list" style="display: none">
			<div class="map-block module-result result_wrap">
				<div class="result-wrapper result_container">
					<h3 class="module-header">
						共
						<span class="highlight">10</span>
						地址
					</h3>
					<div class="result-list search_results">
						<div class="result-block">
							<div class="marker ui_1" ></div>
							<p class="result-name" id="hotelname_1" onclick="choosehotel(this)"></p>	
							<p class="result-price" id="hotelprice_1" onclick="choosehotel(this)"></p>						
						</div>
						<div class="result-block">
							<div class="marker ui_2" ></div>
							<p class="result-name" id="hotelname_2" onclick="choosehotel(this)"></p>
							<p class="result-price" id="hotelprice_2" onclick="choosehotel(this)"></p>							
						</div>
						<div class="result-block">
							<div class="marker ui_3" ></div>
							<p class="result-name" id="hotelname_3" onclick="choosehotel(this)"></p>	
							<p class="result-price" id="hotelprice_3" onclick="choosehotel(this)"></p>						
						</div>
						<div class="result-block">
							<div class="marker ui_4"></div>
							<p class="result-name" id="hotelname_4" onclick="choosehotel(this)"></p>
							<p class="result-price" id="hotelprice_4" onclick="choosehotel(this)"></p>							
						</div>
						<div class="result-block">
							<div class="marker ui_5"></div>
							<p class="result-name" id="hotelname_5" onclick="choosehotel(this)"></p>
							<p class="result-price" id="hotelprice_5" onclick="choosehotel(this)"></p>							
						</div>
						<div class="result-block">
							<div class="marker ui_6"></div>
							<p class="result-name" id="hotelname_6" onclick="choosehotel(this)"></p>
							<p class="result-price" id="hotelprice_6" onclick="choosehotel(this)"></p>							
						</div>
						<div class="result-block">
							<div class="marker ui_7"></div>
							<p class="result-name" id="hotelname_7" onclick="choosehotel(this)"></p>
							<p class="result-price" id="hotelprice_7" onclick="choosehotel(this)"></p>							
						</div>
						<div class="result-block">
							<div class="marker ui_8"></div>
							<p class="result-name" id="hotelname_8" onclick="choosehotel(this)"></p>
							<p class="result-price" id="hotelprice_8" onclick="choosehotel(this)"></p>							
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="echart-container-out" id="echart" style="display:none " onMouseOver="changeBackground_in(this)" onMouseOut="changeBackground_out(this)">
			<div class="echart-container" id="echart_container"  >
			</div>
		</div>
		<div style=" display:none " class="echart-container-wordcloud-out" id="echart_wordcloud" onMouseOver="changeBackground_in(this)" onMouseOut="changeBackground_out(this)">
			<div class="echart-container-wordcloud" id="echart_wordcloud_container">
			</div>
		</div>
		<div style=" display:none " class="echart-container-pie-out" id="echart_pie" onMouseOver="changeBackground_in(this)" onMouseOut="changeBackground_out(this)">
			<div class="echart-container-pie" id="echart_pie_container">
			</div>
		</div>
		
	</div>
</body>


<script src="http://echarts.baidu.com/build/dist/echarts.js"  charset="utf-8"></script>
<script type = "text/javascript">
	var map = new BMap.Map("mapContainer");  
    var point = new BMap.Point(116.331398,39.897445);  
    map.centerAndZoom(point,15);  
	map.enableScrollWheelZoom();   //启用滚轮放大缩小，默认禁用
	map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
	var myGeo = new BMap.Geocoder();//用于逆地址解析
			
	var s = [];  //存储搜索结果
	var v = [];

	var addr = "dizhiweikong";
	var kword_1 = ["拖鞋","冰箱","吹风机","饮料","矿泉水","洗衣机","牙刷","电吹风","微波炉","电视机","无线网络","烟灰缸","洗发液","大厅","游泳池","四合院","院子","健身房","车库","草坪","古香古色"];
	var kword_2 = ["服务态度","经济型","热情周到","服务业","布局合理","室内环境","人员素质","认真负责","安保","接待员","客服","状况良好","有所提高","微笑服务","脾气","全天","商务旅行","价格公道","女服务员","押金","物超所值"];
	var kword_3 = ["小巷","正门","公园","夜市","商业街","博物馆","十字路口","医院","红绿灯","弄堂","剧院","商圈","购物中心","商业区","家乐福","百货","大悦城","新世界","动物园","使馆区","大学"];
	var kword_4 = ["机场","车","飞机","出租车","转机","交通","航站楼","班车","火车","大巴","首都机场","航班","公共汽车","高铁","四号线","一号线","五号线","公交站","自驾游","起步价","主干道"];
	var kword_5 = ["早餐","味道","餐厅","水果","自助餐","口味","咖啡","晚餐","中餐厅","菜品","食物","牛奶","咖啡厅","鸡蛋","午餐","特色小吃","美味","家常","好喝","强烈建议","老字号"];
	var kword_6 = ["面积","光线","朝南","街景","温度","空气","冷热水","气味","卫生间","热水","浴室","洗手间","浴缸","视野","阳台","小窗","大房","视线","尺寸","请勿打扰","安全性"];
	var random_num = new Array();  
	for(var k=0;k<8;k++){
		random_num[k]=new Array();
		
		for(var j=0;j<24;j++){ 
		random_num[k][j] = Math.round(Math.random() * 20);
		//alert(random_num[k][j]);
		 }
	}
	
	//初始加载函数
	window.onload = function(){
		var url=location.search;

		//var Request = new Object();
		
		if(url.indexOf("?")!=-1)
		
		{
					
			var str = url.substr(1);
			var strs= str.split("&");
					
			for(var i=0;i<strs.length;i++)
					
			{
					
			//Request[strs[i].split("=")[0]]=unescape(strs[ i].split("=")[1]);
				v[i] = 	strs[i].split("=")[1];	//解析url获取用户参数
				//alert(v[i]);
			}
					
		}
	};
	
	//用于实现左侧结果列表点击某一个酒店时的响应函数
	function choosehotel(obj){
		//修改三个echart容器的可见性
	 	var Div = document.getElementById("echart");
		if(Div)
		{
		    if(Div.style.display=="none")
		    {
		        Div.style.display="block";
		    }            
		}
		        
		var wcDiv = document.getElementById("echart_wordcloud");
		if(wcDiv)
		{
		    if(wcDiv.style.display=="none")
		    {
		        wcDiv.style.display="block";
		    }            
		}
		        
		var pcDiv = document.getElementById("echart_pie");
		if(pcDiv)
		{
		    if(pcDiv.style.display=="none")
		    {
		        pcDiv.style.display="block";
		    }            
		}
		//判断点击的酒店在列表的位置，给echart赋值		
		var lis = document.getElementsByTagName("p");
		for(var i=0;i<lis.length;i++){ 
			if(obj == lis[i]){	
				var allOverlay = map.getOverlays();	
				for (var j = 0; j < 8 &&j < allOverlay.length; j++){
					//alert(allOverlay[j].point.lng);
					if(s[(Math.round(i/2-0.1))*11]/1000000 == allOverlay[j].point.lng){
						allOverlay[j].setAnimation(BMAP_ANIMATION_BOUNCE);
						alert(i);
						}
					else
						allOverlay[j].setAnimation(null);
				}
				//alert(Math.round(i/2-0.1));	
				//allOverlay[Math.round(i/2-0.1)].setAnimation(BMAP_ANIMATION_BOUNCE);
             	//map.centerAndZoom(new BMap.Point(s[i*11]/1000000, s[i*11+1]/1000000),15);
             	map.panTo(new BMap.Point(s[(Math.round(i/2-0.1))*11]/1000000, s[(Math.round(i/2-0.1))*11+1]/1000000));
				var ar1,ar2,ar3,ar4,ar5,ar6,Tol;
				ar1 = parseFloat(s[11*(Math.round(i/2-0.1))+5]);
				ar2 = parseFloat(s[11*(Math.round(i/2-0.1))+6]);
				ar3 = parseFloat(s[11*(Math.round(i/2-0.1))+7]);
				ar4 = parseFloat(s[11*(Math.round(i/2-0.1))+8]);
				ar5 = parseFloat(s[11*(Math.round(i/2-0.1))+9]);
				ar6 = parseFloat(s[11*(Math.round(i/2-0.1))+10]);
				Tol = ar1+ar2+ar3+ar4+ar5+ar6;
				
				echart((ar1).toFixed(2),(ar2).toFixed(2),(ar3).toFixed(2),(ar4).toFixed(2),(ar5).toFixed(2),(ar6).toFixed(2));
				
				//对展示数据进行调整
				if((ar1/Tol).toFixed(2)<0.1)
					ar1 = 0;
				else 
					ar1 = (ar1/Tol).toFixed(2) - 0.1;
					
				if((ar2/Tol).toFixed(2)<0.1)
					ar2 = 0;
				else 
					ar2 = (ar2/Tol).toFixed(2) - 0.1;
					
				if((ar3/Tol).toFixed(2)<0.1)
					ar3 = 0;
				else 
					ar3 = (ar3/Tol).toFixed(2) - 0.1;
					
				if((ar4/Tol).toFixed(2)<0.1)
					ar4 = 0;
				else 
					ar4 = (ar4/Tol).toFixed(2) - 0.1;
					
				if((ar5/Tol).toFixed(2)<0.1)
					ar5 = 0;
				else 
					ar5 = (ar5/Tol).toFixed(2) - 0.1;
				
				if((ar6/Tol).toFixed(2)<0.1)
					ar6 = 0;
				else 
					ar6 = (ar6/Tol).toFixed(2) - 0.1;
					
				Tol = ar1+ar2+ar3+ar4+ar5+ar6;
				
				echart_wordcloud((ar1/Tol).toFixed(2),(ar2/Tol).toFixed(2),(ar3/Tol).toFixed(2),(ar4/Tol).toFixed(2),(ar5/Tol).toFixed(2),(ar6/Tol).toFixed(2),Math.round(i/2-0.1));
				echart_pie(v[0],v[1],v[2],v[3],v[4],v[5]);
			}
			if(i>16)
				break;
		} 
	}
	
	//在搜索框输入数据之后的处理函数，主要是返回相似地址供用户选择
	function getLocation(obj){
		var d = document.getElementById("locationlist");
		var v = document.getElementById("search_input").value;
		
		if(d && v != '')
        {
            if(d.style.display=="none")
            {
                d.style.display="block";
            }          
        }
        else
        	d.style.display="none";
        
        map.clearOverlays(); //清除地图上所有标记
		
		
		var s=document.getElementById("search_input").value;
		var ls = new BMap.LocalSearch("北京");
		ls.search(s);
		//var i=1;
		ls.setSearchCompleteCallback(function(rs){
			if (ls.getStatus() == BMAP_STATUS_SUCCESS){
					var list = document.getElementsByTagName("li");
					for(var j=0;j<rs.getCurrentNumPois() && j<10;j++)
					{
						if(j<10){
							var poi=rs.getPoi(j);
							
							//map.addOverlay(new BMap.Marker(poi.point)); //如果查询到，则添加红色marker
							list[j].innerHTML = poi.title;
							//+poi.point.lng+","+poi.point.lat+'\n';
						}
					}
					if(rs.getPageIndex!=rs.getNumPages())  
          {  
            //ls.gotoPage(i);
            //i=i+1;
          }
			}});
        
       
	}
	//地址结果列表点击之后的响应函数
	function test(obj){ 
		var d = document.getElementById("locationlist");
		if(d.style.display=="block")
            {
                d.style.display="none";
            }   
            
		for(var i=0; i<8;i++)
			for(var j=0;j<24;j++)
				random_num[i][j] = Math.round(Math.random() * 20);
				
		var v = obj.innerHTML;		
		document.getElementById("search_input").value = v;		
		
		Search();
		
	}
	
	//根据用户选择的地址进行酒店搜索的函数
	function Search(){
		map.clearOverlays(); 
		s.length = 0;
		var val = document.getElementById("search_input").value;
		var lng = 116.301398; 
		var lat = 39.895445;
		if(val != ''){		
			var myGeo_val = new BMap.Geocoder();      
			// 将地址解析结果显示在地图上，并调整地图视野    
			myGeo_val.getPoint(val, function(point){      
				if (point) {      
					//map.centerAndZoom(point, 16);      
					//map.addOverlay(new BMap.Marker(point));
					map.centerAndZoom(point,15);
					//alert(point.lng+","+point.lat);
					lng = point.lng;
					lat = point.lat;
					//alert(lng+" "+lat);
					//alert(v[1]);115.28.33.155
					var url = "http://115.28.33.155:8080/AndroidWeb/androidaction/test.action?lon="+lng*1000000+"&lat="+lat*1000000+"&purpose="+v[6]
							+"&f0="+v[0]/200+"&f1="+v[1]/200+"&f2="+v[2]/200+"&f3="+v[3]/200+"&f4="+v[4]/200+"&f5="+v[5]/200;
	    	//alert(url);58.198.176.244
	    	if(window.XMLHttpRequest){
		             req = new XMLHttpRequest();
		         	}else if(window.ActiveXObject){
		             req = new ActiveXObject("Microsoft.XMLHTTP");
					}
					req.open("GET",url,true);
					req.onreadystatechange = usernameCallback;
					req.send(null);
				}      
			}, "北京市");
    	
    	}
    	else{
    		var iDiv = document.getElementById("hotel_list");
		        if(iDiv)
		        {
		            if(iDiv.style.display=="none")
		            {
		                iDiv.style.display="block";
		            }            
		        }
    	}
    }
    
    //判断访问是否成功，获取返回结果的函数
    function usernameCallback(){
        if(req.readyState == 4){
            if(req.status == 200){
            
	            var iDiv = document.getElementById("hotel_list");
		        if(iDiv)
		        {
		            if(iDiv.style.display=="none")
		            {
		                iDiv.style.display="block";
		            }            
		        }
		        
		       
		        
		       map.clearOverlays();
                var str = req.responseText;
                s = str.split(/\s+/);
				//alert(s[1]/1000);
				var lis = document.getElementsByTagName("p");
				
				for(var i=0; i<8; i++)
					if(i<lis.length ){ 
						var content = s[i*11+2];
						//alert(s[i*11+2]);	
						lis[i*2].innerHTML = s[i*11+2];
						lis[i*2+1].innerHTML = "价格: "+s[i*11+3];
						
						var point1 = new BMap.Point(s[i*11]/1000000, s[i*11+1]/1000000);
						geocodeSearch(point1,content);
						
						//addNewOverlay(s[i*11]/1000000, s[i*11+1]/1000000,content);
						
					} 
            }else{
               var str = req.responseText;
               
				alert("Access Failure!"+req.status);
            }
        }else{
           //var str = req.responseText;
               
				//alert("3"+str);
        }
    }
    
    function addNewOverlay(lng,lat,content){
    	var point = new BMap.Point(lng,lat);	
		var marker = new BMap.Marker(point);
		map.addOverlay(marker);		
		addClickHandler(content,marker);									
		
    }
    
    function addClickHandler(content,marker){
    	marker.addEventListener("click", function(e){
    		//openInfo(content,e);
    		var searchInfoWindow = new BMapLib.SearchInfoWindow(map,content, {
			title  : "酒店信息",      //标题
			width  : 290,             //宽度
			height : 105,              //高度
			panel  : "panel",         //检索结果面板
			enableAutoPan : true,     //自动平移
			searchTypes   :[
				BMAPLIB_TAB_SEARCH,   //周边检索
				BMAPLIB_TAB_TO_HERE,  //到这里去
				BMAPLIB_TAB_FROM_HERE //从这里出发
			]
		});
		searchInfoWindow.open(marker);
    	});
    }
    
    
    /*function openInfo(content,e){
    	//alert(content);          
		var p = e.target;
		var opts = {
						  
						  width : 200,     // 信息窗口宽度
						  height: 120,     // 信息窗口高度
						  title : "信息窗口" , // 信息窗口标题
						  enableMessage:true,//设置允许信息窗发送短息
						 
						};
		//var geoc = new BMap.Geocoder();
			
		var point1 = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
				
				
		var infoWindow = new BMap.InfoWindow(content, opts);  // 创建信息窗口对象 
		map.openInfoWindow(infoWindow,point1); //开启信息窗口
    }*/
    
    function geocodeSearch(pt,content){
		myGeo.getLocation(pt, function(rs){
			var addComp = rs.addressComponents;
			addr = addComp.city + addComp.district +  addComp.street +  addComp.streetNumber;
			//alert(pt.lng);
			var con = "<div class='result-block'><p1 class='result-name' id='infowindow_name' >"+content+"</p1>"
					+"<p1 class='result-price' id='infowindow_addr'>"+"<br\>地址:"+addr+"</p1></div>";
			
							
								
							
			addNewOverlay(pt.lng, pt.lat,con);
		});
	}
	
	
	//雷达图
	function echart(v1,v2,v3,v4,v5,v6){
		var T = 0.2;
		if(v1>T||v2>T||v3>T||v4>T||v5>T||v6>T){
			T = 0.5;
		
			if(v1>T||v2>T||v3>T||v4>T||v5>T||v6>T)
				T = 1;
		}
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
                'echarts/chart/radar' // 使用柱状图就加载bar模块，按需加载
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('echart_container')); 
                
                var option = {
    
    				tooltip : {
        				trigger: 'axis'
    				},
  
    				toolbox: {
       					show : true,
       					feature : {
            				mark : {show: true},
            				dataView : {show: true, readOnly: false},
            				restore : {show: true},
            				saveAsImage : {show: true}
       				 	}		
    				},
    				calculable : true,
    				polar : [
        				{
            				indicator : [
               				 	{text : '设施', max  : T},
                				{text : '服务', max  : T},
                				{text : '位置', max  : T},
                				{text : '交通', max  : T},
                				{text : '餐饮', max  : T},
                				{text : '卫生', max  : T}
            				],
            
        				}
    				],
    				series : [
        				{
            				name: '酒店评分',
            				type: 'radar',
            				itemStyle: {
               				normal: {
                   				areaStyle: {
                       				type: 'default'
                   				}
               				}
           				},
           				data : [
               
               				{
                   				value : [v1, v2, v3, v4, v5, v6],
                   				name : '评分'
               				}
           				]
        			}
    			]
		};
        
            // 为echarts对象加载数据 
            myChart.setOption(option); 
        }
    );
  }
  //字符云
  function echart_wordcloud(v1,v2,v3,v4,v5,v6,p){
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
                'echarts/chart/wordCloud' // 使用柱状图就加载bar模块，按需加载
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('echart_wordcloud_container')); 
                
                
                 function createRandomItemStyle() {
				    return {
				        normal: {
				            color: 'rgb(' + [
				                Math.round(Math.random() * 160),
				                Math.round(Math.random() * 160),
				                Math.round(Math.random() * 160)
				            ].join(',') + ')'
				        }
				    };
				}

				var option = {
				    title: {
				        text: '',
				        link: 'http://www.google.com/trends/hottrends'
				    },
				    tooltip: {
				        show: true
				    },
				    series: [{
				        name: '',
				        type: 'wordCloud',
				        size: ['100%', '100%'],
				        textRotation : [0, 45, 90, -45],
				        textPadding: 0,
				        autoSize: {
				            enable: true,
				            minSize: 14
				        },
				        
				        data: [
				            {
				                name: kword_1[random_num[p][0]],
				                value:  10000*v1+Math.round(Math.random() * 500),
				                itemStyle: {
				                    normal: {
				                        color: 'black'
				                    }
				                }
				            },
				            {
				                name: kword_1[random_num[p][1]],
				                value: 10000*v1+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_1[random_num[p][2]],
				                value: 10000*v1+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_1[random_num[p][3]],
				                value: 10000*v1+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_2[random_num[p][4]],
				                value: 10000*v2+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_2[random_num[p][5]],
				                value: 10000*v2+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_2[random_num[p][6]],
				                value: 10000*v2+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_2[random_num[p][7]],
				                value: 10000*v2+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_3[random_num[p][8]],
				                value: 10000*v3+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_3[random_num[p][9]],
				                value: 10000*v3+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_3[random_num[p][10]],
				                value: 10000*v3+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_3[random_num[p][11]],
				                value: 10000*v3+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_4[random_num[p][12]],
				                value: 10000*v4+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_4[random_num[p][13]],
				                value: 10000*v4+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_4[random_num[p][14]],
				                value: 10000*v4+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_4[random_num[p][15]],
				                value: 10000*v4+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_5[random_num[p][16]],
				                value: 10000*v5+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_5[random_num[p][17]],
				                value: 10000*v5+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_5[random_num[p][18]],
				                value: 10000*v5+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_5[random_num[p][19]],
				                value: 10000*v5+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_6[random_num[p][20]],
				                value: 10000*v6+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_6[random_num[p][21]],
				                value: 10000*v6+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_6[random_num[p][22]],
				                value: 10000*v6+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            },
				            {
				                name: kword_6[random_num[p][23]],
				                value: 10000*v6+Math.round(Math.random() * 500),
				                itemStyle: createRandomItemStyle()
				            }
				        ]
				    }]
				};
				// 为echarts对象加载数据 
                myChart.setOption(option);
        }
    );
  }
  //饼图
  function echart_pie(v1,v2,v3,v4,v5,v6){
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
                var myChart = ec.init(document.getElementById('echart_pie_container')); 
                
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
				  
				    calculable : true,
				    series : [
				        {
				            name:'访问来源',
				            type:'pie',
				            radius : '60%',
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
  //更改三张echart背景透明度
  function changeBackground_in(oDiv){
  	oDiv.style.filter = "alpha(opacity=100%)"; //设置IE的透明度 
	oDiv.style.opacity = 1; //设置fierfox等透明度，注意透明度值是小数 
  }
  function changeBackground_out(oDiv){
  	oDiv.style.filter = "alpha(opacity=70%)"; //设置IE的透明度 
	oDiv.style.opacity = 0.7; //设置fierfox等透明度，注意透明度值是小数 
  }
</script>
<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.js" charset="UTF-8"></script>
</html>


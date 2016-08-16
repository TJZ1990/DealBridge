<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>DealBridge Home Page</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
	    
	    <!--
	   <meta http-equiv="Content-Security-Policy" content="default-src 'self' data: gap: https://ssl.gstatic.com 'unsafe-eval'; style-src 'self' 'unsafe-inline'; media-src *">
        <meta name="format-detection" content="telephone=no">
        <meta name="msapplication-tap-highlight" content="no">
        <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width">
        <link rel="stylesheet" type="text/css" href="/css/jwdindex.css">-->
	    
	    <link href="/bootstrap-3.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
	    <link href="/font-awesome-4.6.3/css/font-awesome.min.css" rel="stylesheet" >
	    <link rel="stylesheet" href="/css/homepage.css">  
	 	<script src="/jquery-2.0.0/jquery.min.js"></script>
	 	<script src="/bootstrap-3.3.6/dist/js/bootstrap.min.js"></script>
		<script src="/js/hammer.min.js"></script>
		
		<script>
          $(function(){
            var myElement= document.getElementById('myCarousel')
            var hm=new Hammer(myElement);
            hm.on("swipeleft",function(){
                $('#myCarousel').carousel('next')
            })
            hm.on("swiperight",function(){
                $('#myCarousel').carousel('prev')
            })
        })
		</script>
		<style>
			#header-text{background-color:#ffffff;padding-top:10px;border-bottom:1px solid #ccc;}
			p.summary{font-family:黑体;font-size:15px;color:#000000;}
			p.description{font-family:黑体;font-size:12px;color:#9A9090;}
			p.clickrate{font-family:黑体;font-size:10px;color:#9A9090;}	
			.category{padding:0;padding-top:60px;margin:0;outline:0;background-color:#ffffff;height:200px;}

			.type{width:20%;float:left;text-align:center;background-color:#ffffff;}
			.type a img{width:50%;}
			.type a{color:#000000;}
			.type a p{margin:0; font-family:Microsoft YaHei;color:rgb(150,150,150);}
			.discount_img{border:0;}
			.tdimg{width:35%;height:100px;}
			.tdcontent{width:65%;height:100px;padding:0;}
			
			a:link{ decoration:none} /* 鏈闂殑閾炬帴 */ 
			a:visited{decoration:none} /* 宸茶闂殑閾炬帴 */ 
			a:hover{text-decoration:none}/* 榧犳爣鍦ㄩ摼鎺ヤ笂 */ 
			a:active{ text-decoration:none}/* 鐐瑰嚮婵�娲婚摼鎺� */ 
			</style>
		
	
		
		<script>
			var startIndex = 5;
			$(window).scroll(function() {
				if ($(window).scrollTop() + $(window).height() >= $(document).height()) {
					if($('#loading-panel').is(":visible") == false){
						$('#loading-panel').show();
						window.setTimeout(function(){
							appendDiscount(startIndex, 5);
							startIndex += 5;
						}, 1000);
					}
				}
			});
		</script>
			

		
			<script>
				function appendDiscount(startIndex, limitNumber) {
				$.getJSON("/api/recommendation/${userId}", {startIndex:startIndex, limitNumber:limitNumber}, function(result){
					for (i in result) {
						console.log(result[i]);
					var str = '<tr data-url="/discount/' + result[i].discountId + '" style="background-color:#ffffff" class="item">' + 
 	  				'<td width="30%" height=120px style="padding:0px 0px 1px 0px;border-top:0px;"><img src="' 
 	  				+ result[i].img + '" width="100%" height="90%"></td><td style="position:relative;border-top:0px;padding-top:0px"><div style="padding:0px 0px 6px 0px; color:#000000; font-size:15px;font-family:Microsoft YaHei;">【' 
 	  				+ result[i].bankName + '】' + result[i].summary + '</div><div style="color:#9a9090;font-size:12px;padding-right:10px;'
					+ 'text-overflow: -o-ellipsis-lastline;overflow: hidden;text-overflow: ellipsis;display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;">' 
 	  				+ result[i].description + '</div><div style="color:#000000;font-size:10px;position:absolute;top:80px;"><i class="fa fa-clock-o" aria-hidden="true" style="color:red;"></i> 活动时间：';
 	  				if (result[i].startTime == null)
 	  					str += '不限';
 	  				else
 	  					str += result[i].startTime;
 	  				str += ' 至 '; 
 	  				if (result[i].endTime == null)
 	  					str += '不限';
 	  				else
 	  					str += result[i].endTime;
 	  				str += '</div></td></tr>';
 	  				$('#recommend-content').append(str);

						
					}
					$('#loading-panel').hide();
				});
			}
			
		</script>
	
		
		<script>
			$(document).ready(function(){
				$('#loading-panel').show();
				appendDiscount(0, 5);
			});
		</script>
		
		
		<style>
			#navbar{background:#F0F0F0; padding:15px}
			#search-icon{position: absolute;top: 10px;left: 10px;}
			#search-input{padding-left: 30px; opacity:0.5; disabled: true}
			#hot-keyword-div{margin: 20px; text-align: center; padding-left:20px; padding-right: 20px;}
			.hot-keyword{border:1px solid #F0F0F0;}
			#search-input-div{float:left; width:280px}
			#search-cancel-div{float:left; margin-left: 20px; margin-top: 8px;}
			#search-record-header{text-align:center; font-size:16px}
		</style>
		
	</head>
	

	<body>
	
	<div id='home-div'>
	
	<!--Navgation Bar-->
    <div class="navbar navbar-fixed-top" style="background-color:#181818;">
	
		<div class="container" style="padding-top:15px;height:30px;">
        
			<div style="height:auto;float:left;">
			  <a href="/citylist"><p style="font-family:黑体;font-size:16px;color:#FFFFFF;">${area}</p></a>
			</div>
			
			<div style="height:auto;float:right;position: relative;">
				<span class="glyphicon glyphicon-search" aria-hidden="true" style="
					position: absolute;
					left: 8px;
					top: 3.5px;
					">
				</span>
				<font face="黑体">
					<input id="search-entry" type="text" placeholder="输入关键字搜索" readonly="readonly" style="border-radius:20px;border:none;width: 200px;padding-left: 30px;transition: 0.3s ease-out;">
				</font>
				<a href="/userInfo" style="padding-left:9px;padding-right:9px;color:#FFFFFF;font-size:16px;"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></a>
			</div>
		
		</div>
	  
    </div>
	



	 <div class="category">
   
      <div class="type">
      <a href="/recommendation/food">
        <img src="/icon/Meal.png"></img>
        <p>美食</p>
        </a>
      </div>
         <div class="type">

      <a href="/recommendation/car">
        <img src="/icon/Car.png"></img>
        <p>洗车</p>
        </a>
      </div>
         <div class="type">

      <a href="/recommendation/outing">
        <img src="/icon/Movie.png"></img>
        <p>出行</p>
        </a>
      </div>
         <div class="type">

      <a href="/recommendation/entertainment">
        <img src="/icon/Entertaiment.png"></img>
        <p>娱乐</p>
        </a>
      </div>
         <div class="type">

      <a href="/recommendation/hotel">
        <img src="/icon/House.png"></img>
        <p>住房</p>
        </a>
      </div>
         <div class="type">

      <a href="/recommendation/hotel">
        <img src="/icon/Hotel.png"></img>
        <p>酒店</p>
        </a>
      </div>
         <div class="type">
      <a href="/recommendation/fashion">
        <img src="/icon/Beauty.png"></img>
        <p>丽人</p>
        </a>
      </div>
         <div class="type">

      <a href="/recommendation/travelling">
        <img src="/icon/Beach.png"></img>
        <p>旅游</p>
        </a>
      </div>
         <div class="type">

      <a href="/recommendation/shopping">
        <img src="/icon/Shop.png"></img>
        <p>购物</p>
        </a>
      </div>
      
      <div class="type">
        <a href="/nearby/?lat=31.2099&lng=121.569">
        <img src="/icon/Near.png"></img>
        <p>附近</p>
        </a>
      </div>
   </div>

	

	
	<div id="myCarousel" class="carousel slide">
	   <!-- 轮播（Carousel）指标 -->
	   <ol class="carousel-indicators">
	      <#list hots as hot>
	          <li data-target="#myCarousel" data-slide-to="${hot_index}" <#if hot_index == 0>class="active"</#if>>
	          </li>
	      </#list>

	   </ol>   
	   <!-- 轮播（Carousel）项目 -->
	   <div class="carousel-inner">
	      <#list hots as hot>
	      	 <div class=<#if hot_index == 0>"item active"<#else>"item"</#if>>
			 	<a href="/discount/${hot.discountId?c}"><img src="${hot.img}" class="center-block" style="width:100%;height:200px;border:0px;"></a>
			 	<div class="carousel-bg"></div>
			 	<div class="carousel-caption"><font color="#FFFFFF" face="黑体">【${hot.bankName}】${hot.summary}</font></div>
		  	 </div>
	      </#list>
	   </div>
	   <!-- 轮播（Carousel）导航 -->
	   <a class="carousel-control left" href="#myCarousel" 
		  data-slide="prev">&lsaquo;</a>
	   <a class="carousel-control right" href="#myCarousel" 
		  data-slide="next">&rsaquo;</a>
	</div> 
	
	<!--Bank entry-->
	<div id="header-text" class="panel-heading">
		<div style="background-color:#ee5555;height:18px;width:4px;float:left;margin-right:6px;padding-top:2px;"></div>
		<h3 class="panel-title">
		<font color="#191919" size="3" face="黑体">
			精选银行
		</font>
		</h3>
	</div>
	<table class="table table-bordered " style="background-color:white; border-left-color:white;border-right:none;text-align:center;margin-bottom:0px;">
    <thead>
    <tbody>
    <tr width="100%" height=50px; >
     
      <td><div><img src="/img/bank/中信银行.png"width=50px;height=50px;><strong style="font-size:20px;font-family:Microsoft YaHei;position:relative;">中信银行</strong></div></td>
     <td><div><img src="/img/bank/中信银行.png"width=50px;height=50px;><strong style="font-size:20px;font-family:Microsoft YaHei;position:relative;">中信银行</strong></div></td>
    </tr>
  	</tbody>
	</table> 
	
	
	<!--Recommend-->
	<div id="header-text" class="panel-heading">
		<div style="background-color:#ee5555;height:18px;width:4px;float:left;margin-right:6px;padding-top:2px;"></div>
		<h3 class="panel-title">
		<font color="#191919" size="3" face="黑体">
			猜你喜欢
		</font>
		</h3>
	</div>
	

		<table class="table table-striped table-hover " style="margin-bottom:0;margin-top:0px;" id="recommend-content"></table>
	<div id="loading-panel" style="display:none">
		<p class="text-center">正在加载...</p>
	</div>
	
</div>
	
	<div id='search-div' style="top:0px; position:absolute; display:none">
		<nav id="navbar" class="navbar navbar-default">
			<div>
				<div id='search-input-div' class="input-group" style="float:left;">
					  <span id="search-icon" class="glyphicon glyphicon-search""></span>
					  <input id="search-input" type="text" class="form-control" placeholder="Search for...">
					  <span class="input-group-btn">
						<button id="search-button" class="btn btn-default" type="button">搜索</button>
					  </span>
					  
				</div>
				<div id='search-cancel-div' style="float:left;">
					<p id='search-hide-button'>取消</p>
				</div>
			</div>
		</nav>
		
		<div id="hot-keyword-div">
			<div class="row">
				<#list hotKeywords as hotKeyword>
					<div class="col-xs-4 col-sm-4 hot-keyword"><p keyword>${hotKeyword}</p></div>
				</#list>
			</div>
		</div>
		
		<div>
			<p id='search-record-header'>搜索记录</p>
			<ul id="search-history-list" class="list-group">
				<#list searchHistories as searchHistory>
			   		<li class="list-group-item" history>${searchHistory}</li>
	 			</#list>
			</ul>
			<h5 id="clear-history-text" class="text-center" onclick="clearSearchHistory(3)">清除搜索记录</h5>
		</div>
		
	
	</div>
	
	
	
	  <script>
			function clearSearchHistory(userId) {
				$("#search-history-list").html("");
				$("#clear-history-text").hide();
				$.ajax({
					type: "POST",
					url: "/api/search_history/" + userId,
					error: function() {
						console.log("clear search history error");
					},
				});
			}
			
			function insertSearchHistory(userId, keyword) {
				if (keyword != "") {
					$.ajax({
						type: "PUT",
						url: "/api/search_history/" + userId,
						data: {keyword: keyword}
					});
				}
			}
			
			$("#search-button").click(function(){
				location.href = "/search_result?query=" + $("#search-input").val();
				insertSearchHistory(3, $("#search-input").val());
			});
			
			$("#search-input").keyup(function () {  
                if (event.which == 13){  
                    insertSearchHistory(3, $("#search-input").val());
                    location.href = "/search_result?query=" + $("#search-input").val();  
                }  
            });   
			
			$("#hot-keyword-div").on('click', $("[keyword]"), function(e){
				insertSearchHistory(3, e.target.outerText);
				location.href = "/search_result?query=" + e.target.outerText;
			});
			
			$("#search-history-list").on('click', $("[history]"), function(e){
				insertSearchHistory(3, e.target.outerText);
				location.href = "/search_result?query=" + e.target.outerText;
			});
			
			
			$(document).ready(function(){
				$('#search-entry').click(function(){
					$('#home-div').hide(150, 'linear');
					$('#search-div').show(150, 'linear');
				});
			});
			
			$(document).ready(function(){
				$('#search-hide-button').click(function(){
					$('#home-div').show(150, 'linear');
					$('#search-div').hide(150, 'linear');
				});
			});
			
		</script>
		
		<script>
			$('table').on('click', 'tr', fun1=function(){
	 	  	location.href = $(this).attr('data-url');
 	  		});
 	  	
		</script>
		
		  <script type="text/javascript" src="cordova.js"></script>
        <script type="text/javascript" src="js/jwdindex.js"></script>
	
</body>
</html>
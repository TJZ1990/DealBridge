<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>DealBridge Home Page</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
	    
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
			#header-text{background-color:rgb(220,220,220);}
			p.summary{font-family:黑体;font-size:15px;color:#000000;}
			p.description{font-family:黑体;font-size:12px;color:#9A9090;}
			p.clickrate{font-family:黑体;font-size:10px;color:#9A9090;}	
				
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
				$.getJSON("/api/recommend/${userId}", {startIndex:startIndex, limitNumber:limitNumber}, function(result){
					for (i in result) {
						console.log(result[i]);
						$('#recommend-content').append('<tr><td width="40%"><img src="' + result[i].img + 
							'" class="img-thumbnail top_pic"></td><td width="60%">' + 
							'<a href="/discount/' + result[i].discountId + '">'+
							'<p class="summary">' + result[i].summary + '</p>' +
							'<p class="description">' + result[i].description + '</p>'+ 
							'<p class="clickrate">' + '点击量：'+ result[i].clickRate + '</p>'+ '</a>' + 
							'</td></tr>');
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
			
			$(document).ready(function(){
				$('#search-input').click(function(){
					$('#home-div').hide();
					$('#search-div').show();
				});
			});
			
			$(document).ready(function(){
				$('#search-hide-button').click(function(){
					$('#home-div').show();
					$('#search-div').hide();
				});
			});
		</script>
		
		
		<style>
			#navbar{background:#F0F0F0; padding:15px}
			#search-icon{position: absolute;top: 10px;left: 10px;}
			#search-input{padding-left: 30px; opacity:0.5}
			#hot-keyword-div{margin: 20px; text-align: center; padding-left:20px; padding-right: 20px;}
			.hot-keyword{border:1px solid #F0F0F0;}
			#search-input-div{float:left; width:320px}
			#search-cancel-div{float:left; margin-left: 20px; margin-top: 8px;}
		</style>
		
	</head>
	
	<body>
	
	<div id='home-div'>
	
	<!--Navgation Bar-->
    <div class="navbar" style="background-color:#181818;">
	
		<div class="container" style="padding-top:15px;height:30px;">
        
			<div style="height:auto;float:left;">
			  <a href="http://m.dianping.com/citylist"><p style="font-family:黑体;font-size:16px;color:#FFFFFF;">上海</p></a>
			</div>
			
			<div style="height:auto;float:right;position: relative;">
				<span class="glyphicon glyphicon-search" aria-hidden="true" style="
					position: absolute;
					left: 8px;
					top: 3.5px;
					">
				</span>
				<font face="黑体">
					<input id="search-input" type="text" placeholder="输入关键字搜索" style="border-radius:20px;border:none;width: 200px;padding-left: 30px;transition: 0.3s ease-out;">
				</font>
				<a href="/userInfo/${userId}" style="padding-left:9px;padding-right:9px;color:#FFFFFF;font-size:16px;"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></a>
			</div>
		
		</div>
	  
    </div>
	


	<div class="row text-center">
		<div class="col-xs-3 col-sm-2 col-md-2" style="border-width: 0;">
		  <a href="/recommend/${userId}/food">
		  	<i class="fa fa-cutlery fa-2x" aria-hidden="true"></i>
		  </a>
		  <p>美食</p>
		</div>
		<div class="col-xs-3 col-sm-2 col-md-2" style="border-width: 0;">
		  <a href="/recommend/${userId}/food">
		    <i class="fa fa-film fa-2x" aria-hidden="true"></i>
		  </a>
		  <p>电影</p>
		</div>
		<div class="col-xs-3 col-sm-2 col-md-2" style="border-width: 0;">
		  <a href="/recommend/${userId}/food">
		    <i class="fa fa-bed fa-2x" aria-hidden="true"></i>
	      </a>
		  <p>酒店</p>
		</div>
		<div class="col-xs-3 col-sm-2 col-md-2" style="border-width: 0;">
		  <a href="/recommend/${userId}/food">
            <i class="fa fa-book fa-2x" aria-hidden="true"></i>
          </a>
		  <p>阅读</p>
		</div>


		<div class="col-xs-3 col-sm-2 col-md-2" style="border-width: 0;">
          <a href="/recommend/${userId}/food">
            <i class="fa fa-bus fa-2x" aria-hidden="true"></i>
		  </a>
		  <p>交通</p>
		</div>
		<div class="col-xs-3 col-sm-2 col-md-2" style="border-width: 0;">
          <a href="/recommend/${userId}/food">
            <i class="fa fa-bicycle fa-2x" aria-hidden="true"></i>
          </a>
		  <p>健身</p>
		</div>
		<div class="col-xs-3 col-sm-2 col-md-2" style="border-width: 0;">
          <a href="/recommend/${userId}/food">
            <i class="fa fa-glass fa-2x" aria-hidden="true"></i>
	      </a>
		  <p>饮品</p>
		</div>
		<div class="col-xs-3 col-sm-2 col-md-2" style="border-width: 0;">
		  <a href="/recommend/${userId}/food">
            <i class="fa fa-plane fa-2x" aria-hidden="true"></i>
		  </a>
		  <p>旅游</p>
		</div>
	</div>
	
	<!--Hot Discount-->
	<div id="header-text" class="panel-heading">
		<h3 class="panel-title">
		<font color="#191919" size="3" face="黑体">
			当前热门
		</font>
		</h3>
	</div>
	
	<div id="myCarousel" class="carousel slide">
	   <!-- 轮播（Carousel）指标 -->
	   <ol class="carousel-indicators">
	      <#list hots as hot>
	          <li data-target="#myCarousel" href="../discount/0" data-slide-to="${hot_index}" <#if hot_index == 0>class="active"</#if>>
	          </li>
	      </#list>

	   </ol>   
	   <!-- 轮播（Carousel）项目 -->
	   <div class="carousel-inner">
	      <#list hots as hot>
	      	 <div class=<#if hot_index == 0>"item active"<#else>"item"</#if>>
			 	<a href="http://localhost:9000/discount/${hot.discountId}"><img src="${hot.img}" class="center-block" style="width:100%;height:200px;"></a>
			 	<div class="carousel-bg"></div>
			 	<div class="carousel-caption"><font color="#FFFFFF" face="黑体">${hot.summary}</font></div>
		  	 </div>
	      </#list>
	   </div>
	   <!-- 轮播（Carousel）导航 -->
	   <a class="carousel-control left" href="#myCarousel" 
		  data-slide="prev">&lsaquo;</a>
	   <a class="carousel-control right" href="#myCarousel" 
		  data-slide="next">&rsaquo;</a>
	</div> 
	
	
	
	<!--Recommend-->
	<div id="header-text" class="panel-heading">
		<h3 class="panel-title">
		<font color="#191919" size="3" face="黑体">
			向您推荐
		</font>
		</h3>
	</div>
	
	<table id="recommend-content">
	</table>
	
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
			<p>搜索记录</p>
			<ul id="search-history-list" class="list-group">
				<#list searchHistories as searchHistory>
			   		<li class="list-group-item" history>${searchHistory}</li>
	 			</#list>
			</ul>
			<h5 id="clear-history-text" class="text-center" onclick="clearSearchHistory(3)">清除搜索记录</h5>
		</div>
		
	
	</div>
	
	
</body>
</html>
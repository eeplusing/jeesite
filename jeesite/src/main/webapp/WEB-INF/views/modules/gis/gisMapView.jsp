<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>汉中gis</title>
    <!-- bootstrap的css -->
	<script src="${pageContext.request.contextPath}/static/libgis/js/jquery-2.1.1.min.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/static/libgis/ol3.10.1/ol.js" type="text/javascript"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/libgis/ol3.10.1/ol.css" type="text/css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/static/libgis/bootstrap3.3.5/bootstrap.min.css" />
    <script src="${pageContext.request.contextPath}/static/libgis/jqueryEasyui/jquery.easyui.min.js" type="text/javascript"></script>
	<link href="${pageContext.request.contextPath}/static/libgis/jqueryEasyui/easyui.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/static/libgis/jqueryEasyui/icon.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/static/libgis/jqueryEasyui/color.css" rel="stylesheet" type="text/css" />
	<!-- 当前页的css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/libgis/opengis/hanzhong.css">
	<style type="text/css">
    	
	</style>
  </head>
  <body>
	<div  class="easyui-window" data-options="title:'工具箱',iconCls:'icon-searchTitle',maximizable:false,minimizable:false,closed:false,border:false,resizable:false,closable:false"  style="width: 300px; height: 450px;padding:5px;left:70%;top:12px;">
      <div class="easyui-layout" data-options="fit:true">
      	<div id="toolBar">
      		<input id = "searchInfo" class="unactiveBtn"  type="button" value="信息查询"/>
      		<input id = "measure" class="unactiveBtn" type="button" value="测量工具"/>
      		<input id = "edit" class="unactiveBtn" type="button" value="地图编辑"/>
      		<input id = "help" class="unactiveBtn" type="button" value="帮助"/>
      	</div>
        <!--信息查询-->
        <div id="searchInfoBoxCpp" class="cpp-tools" style="display:block;">
	        <div><br>
				  图层：
				  <select id="layerList">
					<option>土地</option>
					<option>房屋</option>
					<option>林地</option>
					<option>草原</option>
					<option>海域</option>
				  </select><br><br>
			</div>
			<div id="searchBox">
				<input id="searchContent" type="text" placeholder="输入查询条件 回车搜索" autofocus x-webkit-speech lang="zh-CN">
	  			<input id="searchBtn" type="button" alt="查询" value="查  询" onclick="searchDetail();">
			</div>
			<div style="clear: both;"></div><br>
			<div>
				<input type="button" value="点查询"/>
				<input type="button" value="线查询"/>
				<input type="button" value="矩形查询"/>
			</div>
			<div>
				<h5>查询结果：</h5>
				<div id="info" class="alert alert-success">
				</div>
			</div>
        </div>                   
		<!--测量工具-->
		<div id="measureBoxCpp" class="cpp-tools" style="display:none;"><br>
			<input type="button" value="测量面积"/><br><br>
			<input type="button" value="测量周长"/><br><br>
			<input type="button" value="测量距离"/><br><br>
        </div>
		<!--地图编辑-->
		<div id="editBoxCpp" class="cpp-tools" style="display:none;">
        	<br/>
			 选择图层：
			<select id="layerList">
				<option>土地</option>
				<option>房屋</option>
				<option>林地</option>
				<option>草原</option>
				<option>海域</option>
			</select><br><br>
			<input id="btnDrawPoly" class="btnMenu" type="button" value="添加区"/><br/><br/>
			<input id="btnDrawLine" class="btnMenu" type="button" value="添加线"/><br/><br/>
			<input id="btnDrawPoint" class="btnMenu" type="button" value="添加点"/><br/><br/>
			<input id="btnEdit" class="btnMenu" type="button" value="修    改"/><br/><br/>
			<input id="btnDelete" class="btnMenu" type="button" value="删    除"/><br/><br/>
			<input id="stopEdit" class="btnMenu" type="button" value="停止编辑"/><br/><br/>
        </div>
		<!--帮助-->
		<div id="helpBoxCpp" class="cpp-tools" style="display:none;">
        	<h5>查询操作</h5>
        	<h5>修改操作</h5>
        	<h5>查询操作</h5>
        	<h5>修改操作</h5>
        	<h5>查询操作</h5>
        	<h5>修改操作</h5>
        </div>
     </div>
   </div>
      
  	<div id="map" class="map" style="border:1px solid #F00;">
  	<div id="search_group" class="search_group">
    <input id="search_input" class="search_input">
    <button id="search_button" class="search_button" type="button">搜索！</button>
	</div>
  	</div>
    
    <!-- 当前页的js：
    	地图的主要操作均在此js中定义
     -->
    <script src="${pageContext.request.contextPath}/static/libgis/opengis/hanzhong.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/libgis/opengis/hanzhongModify.js" type="text/javascript"></script>
  </body>
</html>

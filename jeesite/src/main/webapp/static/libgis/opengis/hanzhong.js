
/*********************************创建地图Start*****************************************/
//地图渲染格式  
var format = 'image/png';
//地图的显示边界，在geoserver预览生成的链接中找到边界
var bounds = [393056.71875,3654874.0,423105.46875,3693994.75];

//通过ajax加载geoJson格式的矢量图层数据源
var vectorSource = new ol.source.Vector({
	format: new ol.format.GeoJSON(),
	loader: function(extent, resolution, projection){
		//在geoserver平台预览中，选中GeoJSON格式，复制产生的链接,
		//注意maxFeatures的大小
		var url = 'http://localhost:9000/geoserver/china/wfs?' + 
			'service=WFS&request=GetFeature&' + 
			'version=1.1.0&typename=china:hzxzq&' +  
			'&outputFormat=application%2Fjson';
		$.ajax({
			url: url
		}).done(function(response){
			//将返回的信息添加到vectorSource中
			vectorSource.addFeatures(new ol.format.GeoJSON().readFeatures(response));
		});
	}
});
      
//定义矢量图层
var djqLayerVector = new ol.layer.Vector({
	source: vectorSource
});
      
//定义瓦片图层
var tiled = new ol.layer.Tile({
	visible: true,
	source: new ol.source.TileWMS({
		url: 'http://localhost:9000/geoserver/china/wms',
		params: {
			'FORMAT': format,
			'VERSION': '1.1.0',
			'tiled': true,
			'STYLES': '',
			'LAYERS': 'china:hzdjq',
		}
	})
});
  
//定义坐标
var projection = new ol.proj.Projection({
	code: 'EPSG:2360',
	units: 'm',
	axisOrientation: 'neu'
});
  
//定义地图
var map = new ol.Map({
	//指定地图放入位置,target的值为div的id值
	target: 'map',
	//指定地图中的图层
	layers:[tiled, djqLayerVector],
	//投影视图设置
	view: new ol.View({
		projection: projection
	})
});
//地图自适应bounds
map.getView().fit(bounds, map.getSize());
/*********************************创建地图End*****************************************/      

/*********************************操作控件Start*****************************************/
//鼠标位置处的坐标
var mousePositionControl = new ol.control.MousePosition({
	coordinateFormat: ol.coordinate.createStringXY(5),
});
//鹰眼总览图控件
var overviewMapControl =  new ol.control.OverviewMap({
	collapsed: false
});
//全屏控件
var fullScreenControl =  new ol.control.FullScreen();
//添加控件
map.addControl(mousePositionControl);
map.addControl(overviewMapControl);
map.addControl(fullScreenControl);
map.addControl(new ol.control.ZoomSlider());
/*********************************操作控件End*****************************************/    

/*********************************定位动画Start*****************************************/
var point_div = document.createElement("div");
point_div.setAttribute("id", "css_animation");
var point_overlay = new ol.Overlay({
	element: point_div,
	positioning: 'center-center'
});
map.addOverlay(point_overlay);
point_overlay.setPosition([409663,3661548]);
/*********************************定位动画End*****************************************/

/*********************************工具栏Start*****************************************/
$("#toolBar input").each(function(){
	$(this).click(function(){
		$("#toolBar input").each(function(){
			$(this).removeClass("activeBtn");
		});
		$(this).removeClass("unactiveBtn");
		$(this).addClass("activeBtn");
		var lid = $(this).attr("id") + "BoxCpp";
		$(".cpp-tools").each(function(){
			if($(this).attr("id") == lid){
				$(this).css("display", "block");
			}else{
				$(this).css("display", "none");
			}
		});
	});
});
/*********************************工具栏End*****************************************/	

/******************交互矩形框选查询Start********************/
// a normal select interaction to handle click
var select = new ol.interaction.Select({
	style: new ol.style.Style({
		stroke: new ol.style.Stroke({color: '#FFB900',width: 1
		}),
		fill: new ol.style.Fill({
			color: '#E84850'
		})
	})
});
map.addInteraction(select);
var selectedFeatures = select.getFeatures();
  
// a DragBox interaction used to select features by drawing boxes
//定义矩形框
var dragBox = new ol.interaction.DragBox({
	//按下shift键
	condition: ol.events.condition.shiftKeyOnly,
	style: new ol.style.Style({
		stroke: new ol.style.Stroke({color: [255, 196, 85, 1]})
	})
});
  
map.addInteraction(dragBox);
//定义显示信息的DOM
var infoBox = document.getElementById('info');
  
/**清空选择集**/
// clear selection when drawing a new box and when clicking on the map
dragBox.on('boxstart', function(e){
	selectedFeatures.clear();
	infoBox.innerHTML = '&nbsp;';
});
map.on('click', function(){
	selectedFeatures.clear();
	infoBox.innerHTML = '&nbsp;';
});
  
//绑定矩形绘制完成事件
dragBox.on('boxend', function(e){
	// features that intersect the box are added to the collection of 
	//selected features, and their names are displayed in the "info" div
	//数组定义格式
	var info = [];
	//获取与矩形相交得到的要素集合
	var extent = dragBox.getGeometry().getExtent();
	//遍历与矩形相交的要素集合，将要素信息加入到info div中
	vectorSource.forEachFeatureIntersectingExtent(extent, function(feature){
		selectedFeatures.push(feature);
		info.push("名称：" + feature.get('xzqmc') + ";计算面积：" + feature.get('jsmj'));
	}); 
	if (info.length > 0){
		infoBox.innerHTML = info.join('<br>');
    }
});
/******************交互框选查询End********************/

/******************点击查询Start********************/
//定义叠加层 Overlay
var overlay = new ol.Overlay({
	element: $('<div id="myOverlay" class="overlay"><span id="coordinate" class="label label-primary">0, 0</span></div> '),
	positioning: 'top-right',
    stopEvent: true,
    insertFirst: false
});
map.addOverlay(overlay);
  
//前面以为map绑定过click事件,这里又再次绑定，说明可以绑定多个方法
//overlay在鼠标点击位置显示
map.on('click', function(event){
	$('#coordinate').text("");
	//Set position
	overlay.setPosition(event.coordinate);
});
  
var selectClick = new ol.interaction.Select({
	condition: ol.events.condition.singleClick,
	style: new ol.style.Style({
		stroke: new ol.style.Stroke({color: '#FFB900',width: 1
		}),
		fill: new ol.style.Fill({
			color: '#E84850'
		})
	})
});
map.addInteraction(selectClick);

//单击选择图元，更新overlay内容
selectClick.on('select', function(){
	if(selectClick.getFeatures().getLength() > 0){
		var pointExtentFeature = selectClick.getFeatures().item(0);
		// Update overlay label
		$('#coordinate').text("名称：" + pointExtentFeature.get('xzqmc') + 
				",计算面积 ：" + pointExtentFeature.get('jsmj'));
		// Show overlay
		$(overlay.getElement()).show(); 
	}
});
/******************点击查询End********************/
 
/******************条件查询Start********************/
function searchDetail(){
	selectedFeatures.clear();
	$('#coordinate').text("");
	var selectFilter = $("#searchContent").val();
	var targetFeature = null;
	var info = [];
	vectorSource.forEachFeature(function(feature){
			if(null != feature.get('xzqmc') && "" != feature.get('xzqmc') && feature.get('xzqmc').indexOf(selectFilter) >= 0){
				targetFeature = feature;
				selectedFeatures.push(feature);
				info.push("名称：" + targetFeature.get('xzqmc') + ";计算面积：" + targetFeature.get('jsmj'));
			}
	  	},
	  	this
  );
  infoBox.innerHTML = "&nbsp;";
  infoBox.innerHTML = info.join('<br>');
};
/******************条件查询End********************/    
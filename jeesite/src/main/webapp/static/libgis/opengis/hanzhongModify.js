
/*********************************地图编辑Start*****************************************/	
var modifyInteraction;
var modifySelect = new ol.interaction.Select({
	style: new ol.style.Style({
		stroke: new ol.style.Stroke({
			color: '#FF2828'
		})
	})
});

//wfs-t
var dirty = {};

var formatWFS = new ol.format.WFS();
var writeOptions = {
	featureNS:'http://www.eplusing.com/china',//geoserver中工作区设置的命名空间，Required
	featurePrefix:'china',//Required
	featureType:'hzxzq',//Required
	srsName:'EPSG:2360'
};
/*var formatGML = new ol.format.GML({
	 featureNS: 'http://localhost:9000/geoserver/china', //geoserver中工作区设置的命名空间，Required
     //featurePrefix:'china', //Required
     featureType: 'china:hzxzq', //Required
     srsName: 'EPSG:2360'
	});*/
var transactWFS = function(p,f) {
	switch(p) {
	case 'insert':
		node = formatWFS.writeTransaction([f],null,null,writeOptions);
		break;
	case 'update':
		node = formatWFS.writeTransaction(null,[f],null,writeOptions);
		break;
	case 'delete':
		node = formatWFS.writeTransaction(null,null,[f],writeOptions);
		break;
	}
	s = new XMLSerializer();
	/**/
	str = s.serializeToString(node);//对xml字符创进行处理
	var xmlTransactionData = $.parseXML(str);
	alert(str);
	/**
	 * 根据增、删、改对xmlTransactionData进行编辑：
	 * 删除：不需要修改
	 * 添加：需要将所有字段信息添加进去，字段根据数据表进行添加，字段的值来源：键盘输入、文件导入（要对数据进行校验）；
	 * 修改：将修改的信息添加进去
	 * */
	
	$.ajax('http://localhost:9000/geoserver/china/wfs',{
		type: 'POST',
		dataType: 'xml',
		processData: false,
		contentType: 'text/xml',
		data: str
		}).done(); 
};

$('.btnMenu').on('click', function(event) {
	$('.btnMenu').removeClass('orange');
	//$(this).addClass('orange');
	map.removeInteraction(modifyInteraction);
	modifySelect.getFeatures().clear();
	map.removeInteraction(modifySelect);
	map.removeInteraction(selectClick);
	switch($(this).attr('id')) {
	
		case 'btnSelect':
			modifyInteraction = new ol.interaction.Select({
				style: new ol.style.Style({
					stroke: new ol.style.Stroke({color: '#f50057', width: 2})
					})
			});
			map.addInteraction(modifyInteraction);
			modifyInteraction.getFeatures().on('add', function(e) {
				props = e.element.getProperties();
				if (props.status){$('#popup-status').html(props.status);}else{$('#popup-status').html('n/a');}
				if (props.tiendas){$('#popup-tiendas').html(props.tiendas);}else{$('#popup-tiendas').html('n/a');}
				coord = $('.ol-mouse-position').html().split(',');
				overlayPopup.setPosition(coord);
				});
			break;
			
		case 'btnEdit':
			map.addInteraction(modifySelect);
			modifyInteraction = new ol.interaction.Modify({
				features: modifySelect.getFeatures()
				});
			map.addInteraction(modifyInteraction);
			
			snap = new ol.interaction.Snap({
				features: modifySelect.getFeatures(),
				source: djqLayerVector.getSource()
				});
			map.addInteraction(snap);
			
			dirty = {};
			modifySelect.getFeatures().on('add', function(e) {
				e.element.on('change', function(e) {
					dirty[e.target.getId()] = true;
					});
				});
			modifySelect.getFeatures().on('remove', function(e) {
				f = e.element;
				if (dirty[f.getId()]){
					delete dirty[f.getId()];
					featureProperties = f.getProperties();
				    delete featureProperties.boundedBy;
				    var clone = new ol.Feature(featureProperties);
				    clone.setId(f.getId());
				    transactWFS('update',clone);
					}
				});
			break;
			
		case 'btnDrawPoint':
			modifyInteraction = new ol.interaction.Draw({
			    type: 'Point',
			    source: djqLayerVector.getSource()
			});
			map.addInteraction(modifyInteraction);
			modifyInteraction.on('drawend', function(e) {
				transactWFS('insert',e.feature);
		    });
			break;
			
		case 'btnDrawLine':
			modifyInteraction = new ol.interaction.Draw({
			    type: 'LineString',
			    source: djqLayerVector.getSource()
			});
			map.addInteraction(modifyInteraction);
			interaction.on('drawend', function(e) {
				transactWFS('insert',e.feature);
		    });
			break;
			
		case 'btnDrawPoly':
			modifyInteraction = new ol.interaction.Draw({
			    type: 'MultiPolygon',
			    source: djqLayerVector.getSource()
			});
			map.addInteraction(modifyInteraction);
			modifyInteraction.on('drawend', function(e) {
				transactWFS('insert',e.feature);
		    });
			break;
			
		case 'btnDelete':
			modifyInteraction = new ol.interaction.Select();
			map.addInteraction(modifyInteraction);
			modifyInteraction.getFeatures().on('change:length', function(e) {
				transactWFS('delete',e.target.item(0));
				modifyInteraction.getFeatures().clear();
		        //selectPointerMove.getFeatures().clear();
		    });
			break;
		default:
			break;
	}
});

/*停止编辑，清除所有处于选中状态的要素*/
$('.stopEdit').on('click', function(){
	map.removeInteraction(modifyInteraction);
});

/*********************************地图编辑End*****************************************/
      
      
      
      
      
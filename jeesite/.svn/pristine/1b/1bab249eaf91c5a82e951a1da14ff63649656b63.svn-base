/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gis.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.thinkgem.jeesite.common.web.BaseController;

/**
 * GIS地图显示
 * @author Caopengpeng
 * @version 2016-06-19
 */
@Controller
@RequestMapping(value = "${adminPath}/gis/gisShow")
public class GisShowController extends BaseController {

	@RequiresPermissions("gis:gisShow:view")
	@RequestMapping(value = "mapview")
	public String showMap(){
		return "modules/gis/gisMapView";
	}
}
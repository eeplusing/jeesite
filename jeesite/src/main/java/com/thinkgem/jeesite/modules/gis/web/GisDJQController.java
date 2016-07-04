/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gis.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gis.entity.GisDJQ;
import com.thinkgem.jeesite.modules.gis.service.GisDJQService;

/**
 * GIS管理Controller
 * @author Caopengpeng
 * @version 2016-06-19
 */
@Controller
@RequestMapping(value = "${adminPath}/gis/gisDJQ")
public class GisDJQController extends BaseController {

	@Autowired
	private GisDJQService gisDJQService;
	
	@ModelAttribute
	public GisDJQ get(@RequestParam(required=false) String id) {
		GisDJQ entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = gisDJQService.get(id);
		}
		if (entity == null){
			entity = new GisDJQ();
		}
		return entity;
	}
	
	@RequiresPermissions("gis:gisDJQ:view")
	@RequestMapping(value = {"list", ""})
	public String list(GisDJQ gisDJQ, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<GisDJQ> page = gisDJQService.findPage(new Page<GisDJQ>(request, response), gisDJQ); 
		model.addAttribute("page", page);
		return "modules/gis/gisDJQList";
	}

	@RequiresPermissions("gis:gisDJQ:view")
	@RequestMapping(value = "form")
	public String form(GisDJQ gisDJQ, Model model) {
		model.addAttribute("gisDJQ", gisDJQ);
		return "modules/gis/gisDJQForm";
	}

	@RequiresPermissions("gis:gisDJQ:edit")
	@RequestMapping(value = "save")
	public String save(GisDJQ gisDJQ, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, gisDJQ)){
			return form(gisDJQ, model);
		}
		gisDJQService.save(gisDJQ);
		addMessage(redirectAttributes, "保存数据操作成功成功");
		return "redirect:"+Global.getAdminPath()+"/gis/gisDJQ/?repage";
	}
	
	@RequiresPermissions("gis:gisDJQ:edit")
	@RequestMapping(value = "delete")
	public String delete(GisDJQ gisDJQ, RedirectAttributes redirectAttributes) {
		gisDJQService.delete(gisDJQ);
		addMessage(redirectAttributes, "删除数据操作成功成功");
		return "redirect:"+Global.getAdminPath()+"/gis/gisDJQ/?repage";
	}

}
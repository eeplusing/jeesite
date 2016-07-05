/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gis.entity;

import org.hibernate.validator.constraints.Length;
import java.util.List;
import com.google.common.collect.Lists;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * GIS管理Entity
 * @author Caopengpeng
 * @version 2016-06-19
 */
public class GisDJQ extends DataEntity<GisDJQ> {
	
	private static final long serialVersionUID = 1L;
	private String djqUnitCode;		// 不动产单元号
	private String area;		// 面积
	private String name;		// 地籍区名称
	private String owner;		// 所有人
	private List<GisDJZQ> gisDJZQList = Lists.newArrayList();		// 子表列表
	
	public GisDJQ() {
		super();
	}

	public GisDJQ(String id){
		super(id);
	}

	@Length(min=1, max=64, message="不动产单元号长度必须介于 1 和 64 之间")
	public String getDjqUnitCode() {
		return djqUnitCode;
	}

	public void setDjqUnitCode(String djqUnitCode) {
		this.djqUnitCode = djqUnitCode;
	}
	
	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}
	
	@Length(min=0, max=100, message="地籍区名称长度必须介于 0 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=255, message="所有人长度必须介于 0 和 255 之间")
	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}
	
	public List<GisDJZQ> getGisDJZQList() {
		return gisDJZQList;
	}

	public void setGisDJZQList(List<GisDJZQ> gisDJZQList) {
		this.gisDJZQList = gisDJZQList;
	}
}
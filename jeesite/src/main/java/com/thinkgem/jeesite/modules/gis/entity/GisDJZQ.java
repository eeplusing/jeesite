/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gis.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * GIS管理Entity
 * @author Caopengpeng
 * @version 2016-06-19
 */
public class GisDJZQ extends DataEntity<GisDJZQ> {
	
	private static final long serialVersionUID = 1L;
	private GisDJQ gisDjqId;		// 地籍区Id 父类
	private String name;		// 地籍子区名称
	private String djzqUnitCode;		// 不动产单元号
	
	public GisDJZQ() {
		super();
	}

	public GisDJZQ(String id){
		super(id);
	}

	public GisDJZQ(GisDJQ gisDjqId){
		this.gisDjqId = gisDjqId;
	}

	@Length(min=1, max=64, message="地籍区Id长度必须介于 1 和 64 之间")
	public GisDJQ getGisDjqId() {
		return gisDjqId;
	}

	public void setGisDjqId(GisDJQ gisDjqId) {
		this.gisDjqId = gisDjqId;
	}
	
	@Length(min=0, max=100, message="地籍子区名称长度必须介于 0 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=64, message="不动产单元号长度必须介于 1 和 64 之间")
	public String getDjzqUnitCode() {
		return djzqUnitCode;
	}

	public void setDjzqUnitCode(String djzqUnitCode) {
		this.djzqUnitCode = djzqUnitCode;
	}
	
}
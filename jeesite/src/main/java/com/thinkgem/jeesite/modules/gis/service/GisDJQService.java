/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gis.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gis.entity.GisDJQ;
import com.thinkgem.jeesite.modules.gis.dao.GisDJQDao;
import com.thinkgem.jeesite.modules.gis.entity.GisDJZQ;
import com.thinkgem.jeesite.modules.gis.dao.GisDJZQDao;

/**
 * GIS管理Service
 * @author Caopengpeng
 * @version 2016-06-19
 */
@Service
@Transactional(readOnly = true)
public class GisDJQService extends CrudService<GisDJQDao, GisDJQ> {

	@Autowired
	private GisDJZQDao gisDJZQDao;
	
	public GisDJQ get(String id) {
		GisDJQ gisDJQ = super.get(id);
		gisDJQ.setGisDJZQList(gisDJZQDao.findList(new GisDJZQ(gisDJQ)));
		return gisDJQ;
	}
	
	public List<GisDJQ> findList(GisDJQ gisDJQ) {
		return super.findList(gisDJQ);
	}
	
	public Page<GisDJQ> findPage(Page<GisDJQ> page, GisDJQ gisDJQ) {
		return super.findPage(page, gisDJQ);
	}
	
	@Transactional(readOnly = false)
	public void save(GisDJQ gisDJQ) {
		super.save(gisDJQ);
		for (GisDJZQ gisDJZQ : gisDJQ.getGisDJZQList()){
			if (gisDJZQ.getId() == null){
				continue;
			}
			if (GisDJZQ.DEL_FLAG_NORMAL.equals(gisDJZQ.getDelFlag())){
				if (StringUtils.isBlank(gisDJZQ.getId())){
					gisDJZQ.setGisDjqId(gisDJQ);
					gisDJZQ.preInsert();
					gisDJZQDao.insert(gisDJZQ);
				}else{
					gisDJZQ.preUpdate();
					gisDJZQDao.update(gisDJZQ);
				}
			}else{
				gisDJZQDao.delete(gisDJZQ);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(GisDJQ gisDJQ) {
		super.delete(gisDJQ);
		gisDJZQDao.delete(new GisDJZQ(gisDJQ));
	}
	
}
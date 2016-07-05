
/* Drop Indexes */

DROP INDEX test_data_child_del_flag;
DROP INDEX test_data_main_del_flag;



/* Drop Tables */

DROP TABLE gisdjzq CASCADE CONSTRAINTS;
DROP TABLE gis_djq CASCADE CONSTRAINTS;




/* Create Tables */

-- 业务数据子表
CREATE TABLE gisdjzq
(
	-- 编号
	id varchar2(64) NOT NULL,
	-- 业务主表ID
	gis_djq_id varchar2(64) NOT NULL,
	-- 名称
	name nvarchar2(100),
	-- 创建者
	create_by varchar2(64) NOT NULL,
	-- 创建时间
	create_date timestamp NOT NULL,
	-- 更新者
	update_by varchar2(64) NOT NULL,
	-- 更新时间
	update_date timestamp NOT NULL,
	-- 备注信息
	remarks nvarchar2(255),
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' NOT NULL,
	unit_code nvarchar2(64) NOT NULL,
	PRIMARY KEY (id)
);


-- 业务数据表
CREATE TABLE gis_djq
(
	-- 编号
	id varchar2(64) NOT NULL UNIQUE,
	-- 归属用户
	unit_code varchar2(64),
	-- 地籍区面积
	area float(24),
	-- 归属区域
	area_id nvarchar2(64),
	-- 名称
	name nvarchar2(100),
	-- 创建者
	create_by varchar2(64) NOT NULL,
	-- 创建时间
	create_date timestamp NOT NULL,
	-- 更新者
	update_by varchar2(64) NOT NULL,
	-- 更新时间
	update_date timestamp NOT NULL,
	-- 备注信息
	remarks nvarchar2(255),
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' NOT NULL,
	owner varchar2(255),
	PRIMARY KEY (id)
);



/* Create Foreign Keys */

ALTER TABLE gisdjzq
	ADD FOREIGN KEY (gis_djq_id)
	REFERENCES gis_djq (id)
;



/* Create Indexes */

CREATE INDEX test_data_child_del_flag ON gisdjzq ();
CREATE INDEX test_data_main_del_flag ON gis_djq ();



/* Comments */

COMMENT ON TABLE gisdjzq IS '业务数据子表';
COMMENT ON COLUMN gisdjzq.id IS '编号';
COMMENT ON COLUMN gisdjzq.gis_djq_id IS '业务主表ID';
COMMENT ON COLUMN gisdjzq.name IS '名称';
COMMENT ON COLUMN gisdjzq.create_by IS '创建者';
COMMENT ON COLUMN gisdjzq.create_date IS '创建时间';
COMMENT ON COLUMN gisdjzq.update_by IS '更新者';
COMMENT ON COLUMN gisdjzq.update_date IS '更新时间';
COMMENT ON COLUMN gisdjzq.remarks IS '备注信息';
COMMENT ON COLUMN gisdjzq.del_flag IS '删除标记（0：正常；1：删除）';
COMMENT ON TABLE gis_djq IS '业务数据表';
COMMENT ON COLUMN gis_djq.id IS '编号';
COMMENT ON COLUMN gis_djq.unit_code IS '归属用户';
COMMENT ON COLUMN gis_djq.area IS '地籍区面积';
COMMENT ON COLUMN gis_djq.area_id IS '归属区域';
COMMENT ON COLUMN gis_djq.name IS '名称';
COMMENT ON COLUMN gis_djq.create_by IS '创建者';
COMMENT ON COLUMN gis_djq.create_date IS '创建时间';
COMMENT ON COLUMN gis_djq.update_by IS '更新者';
COMMENT ON COLUMN gis_djq.update_date IS '更新时间';
COMMENT ON COLUMN gis_djq.remarks IS '备注信息';
COMMENT ON COLUMN gis_djq.del_flag IS '删除标记（0：正常；1：删除）';




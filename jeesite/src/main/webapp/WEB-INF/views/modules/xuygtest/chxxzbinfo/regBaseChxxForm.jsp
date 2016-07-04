<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>带有坐标管理的测绘信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
		function addRow(list, idx, tpl, row){
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
			}));
			$(list+idx).find("select").each(function(){
				$(this).val($(this).attr("data-value"));
			});
			$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
				var ss = $(this).attr("data-value").split(',');
				for (var i=0; i<ss.length; i++){
					if($(this).val() == ss[i]){
						$(this).attr("checked","checked");
					}
				}
			});
		}
		function delRow(obj, prefix){
			var id = $(prefix+"_id");
			var delFlag = $(prefix+"_delFlag");
			if (id.val() == ""){
				$(obj).parent().parent().remove();
			}else if(delFlag.val() == "0"){
				delFlag.val("1");
				$(obj).html("&divide;").attr("title", "撤销删除");
				$(obj).parent().parent().addClass("error");
			}else if(delFlag.val() == "1"){
				delFlag.val("0");
				$(obj).html("&times;").attr("title", "删除");
				$(obj).parent().parent().removeClass("error");
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/xuygtest/chxxzbinfo/regBaseChxx/">带有坐标管理的测绘信息列表</a></li>
		<li class="active"><a href="${ctx}/xuygtest/chxxzbinfo/regBaseChxx/form?id=${regBaseChxx.id}">带有坐标管理的测绘信息<shiro:hasPermission name="xuygtest:chxxzbinfo:regBaseChxx:edit">${not empty regBaseChxx.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="xuygtest:chxxzbinfo:regBaseChxx:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="regBaseChxx" action="${ctx}/xuygtest/chxxzbinfo/regBaseChxx/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">权利人姓名：</label>
			<div class="controls">
				<form:input path="qlrmc" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">证件类型：</label>
			<div class="controls">
				<form:select path="zjlx" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('reg_bus_zjlx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">证件号：</label>
			<div class="controls">
				<form:input path="zjhm" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">县级行政区：</label>
			<div class="controls">
				<form:select path="seachprov" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('reg_bus_xq')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">地籍区：</label>
			<div class="controls">
				<form:select path="seachcity" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('reg_bus_djq')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">地籍子区：</label>
			<div class="controls">
				<form:select path="seachdistrict" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('reg_bus_djzq')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">坐落：</label>
			<div class="controls">
				<form:textarea path="zl" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">宗地四至-东：</label>
			<div class="controls">
				<form:input path="zdszd" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">宗地四至-南：</label>
			<div class="controls">
				<form:input path="zdszn" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">宗地四至-西：</label>
			<div class="controls">
				<form:input path="zdszx" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">宗地四至-北：</label>
			<div class="controls">
				<form:input path="zdszb" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">界址点坐标：</label>
			<div class="controls">
				<form:textarea path="jzdzb" htmlEscape="false" rows="4" maxlength="500" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">宗地图：</label>
			<div class="controls">
				<form:hidden id="zdt" path="zdt" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="zdt" type="files" uploadPath="/xuygtest/chxxzbinfo/regBaseChxx" selectMultiple="true"/>
			</div>
		</div>
			<div class="control-group">
				<label class="control-label">坐标信息表：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>坐标点名称</th>
								<th>X坐标值</th>
								<th>Y坐标值</th>
								<shiro:hasPermission name="xuygtest:chxxzbinfo:regBaseChxx:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="regBaseZbinfoList">
						</tbody>
						<shiro:hasPermission name="xuygtest:chxxzbinfo:regBaseChxx:edit"><tfoot>
							<tr><td colspan="5"><a href="javascript:" onclick="addRow('#regBaseZbinfoList', regBaseZbinfoRowIdx, regBaseZbinfoTpl);regBaseZbinfoRowIdx = regBaseZbinfoRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="regBaseZbinfoTpl">//<!--
						<tr id="regBaseZbinfoList{{idx}}">
							<td class="hide">
								<input id="regBaseZbinfoList{{idx}}_id" name="regBaseZbinfoList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="regBaseZbinfoList{{idx}}_delFlag" name="regBaseZbinfoList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="regBaseZbinfoList{{idx}}_zbdmc" name="regBaseZbinfoList[{{idx}}].zbdmc" type="text" value="{{row.zbdmc}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="regBaseZbinfoList{{idx}}_zbx" name="regBaseZbinfoList[{{idx}}].zbx" type="text" value="{{row.zbx}}" maxlength="50" class="input-small "/>
							</td>
							<td>
								<input id="regBaseZbinfoList{{idx}}_zby" name="regBaseZbinfoList[{{idx}}].zby" type="text" value="{{row.zby}}" maxlength="50" class="input-small "/>
							</td>
							<shiro:hasPermission name="xuygtest:chxxzbinfo:regBaseChxx:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#regBaseZbinfoList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var regBaseZbinfoRowIdx = 0, regBaseZbinfoTpl = $("#regBaseZbinfoTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(regBaseChxx.regBaseZbinfoList)};
							for (var i=0; i<data.length; i++){
								addRow('#regBaseZbinfoList', regBaseZbinfoRowIdx, regBaseZbinfoTpl, data[i]);
								regBaseZbinfoRowIdx = regBaseZbinfoRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="xuygtest:chxxzbinfo:regBaseChxx:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
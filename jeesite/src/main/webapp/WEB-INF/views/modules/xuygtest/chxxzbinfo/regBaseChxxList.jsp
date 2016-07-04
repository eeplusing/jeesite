<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>带有坐标管理的测绘信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/xuygtest/chxxzbinfo/regBaseChxx/">带有坐标管理的测绘信息列表</a></li>
		<shiro:hasPermission name="xuygtest:chxxzbinfo:regBaseChxx:edit"><li><a href="${ctx}/xuygtest/chxxzbinfo/regBaseChxx/form">带有坐标管理的测绘信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="regBaseChxx" action="${ctx}/xuygtest/chxxzbinfo/regBaseChxx/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>权利人姓名：</label>
				<form:input path="qlrmc" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>权利人姓名</th>
				<th>证件类型</th>
				<th>证件号</th>
				<th>坐落</th>
				<th>宗地四至-东</th>
				<th>宗地四至-南</th>
				<th>宗地四至-西</th>
				<th>宗地四至-北</th>
				<th>创建时间</th>
				<th>更新时间</th>
				<shiro:hasPermission name="xuygtest:chxxzbinfo:regBaseChxx:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="regBaseChxx">
			<tr>
				<td><a href="${ctx}/xuygtest/chxxzbinfo/regBaseChxx/form?id=${regBaseChxx.id}">
					${regBaseChxx.qlrmc}
				</a></td>
				<td>
					${fns:getDictLabel(regBaseChxx.zjlx, 'reg_bus_zjlx', '')}
				</td>
				<td>
					${regBaseChxx.zjhm}
				</td>
				<td>
					${regBaseChxx.zl}
				</td>
				<td>
					${regBaseChxx.zdszd}
				</td>
				<td>
					${regBaseChxx.zdszn}
				</td>
				<td>
					${regBaseChxx.zdszx}
				</td>
				<td>
					${regBaseChxx.zdszb}
				</td>
				<td>
					<fmt:formatDate value="${regBaseChxx.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${regBaseChxx.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="xuygtest:chxxzbinfo:regBaseChxx:edit"><td>
    				<a href="${ctx}/xuygtest/chxxzbinfo/regBaseChxx/form?id=${regBaseChxx.id}">修改</a>
					<a href="${ctx}/xuygtest/chxxzbinfo/regBaseChxx/delete?id=${regBaseChxx.id}" onclick="return confirmx('确认要删除该带有坐标管理的测绘信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<button formaction="${prefix}/create" ${empty form.id ? '' : 'disabled'} class="btn btn-primary">
	<span class="glyphicon glyphicon-plus"></span> Create
</button>
<button formaction="${prefix}/update" ${empty form.id ? 'disabled' : ''} class="btn btn-success">
	<span class="glyphicon glyphicon-save"></span> Update
</button>
<button formaction="${prefix}/delete/${form.id}" ${empty form.id ? 'disabled' : ''} class="btn btn-danger">
	<span class="glyphicon glyphicon-trash"></span> Delete
</button>
<a href="${prefix}/index" class="btn btn-info">
	<span class="glyphicon glyphicon-refresh"></span> Reset
</a>
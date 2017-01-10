<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript" src="${staticPath }/static/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
<script type="text/javascript" src="${staticPath }/static/js/warehouse.js" charset="utf-8"></script>
<script type="text/javascript">
    $(function () {
        $('#shipmentMoneyForm').form({
            url: '${path }/shipment/shipment/Money',
            onSubmit: function () {
                progressLoad();
                var isValid = $(this).form('enableValidation').form('validate');
                if (!isValid) {
                    progressClose();
                }
                return isValid;
            },
            success: function (result) {
                progressClose();
                result = $.parseJSON(result);
                if (result.success) {
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    parent.$.messager.alert('错误', result.msg, 'error');
                }
            }
        });
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="shipmentMoneyForm" method="post">
            <table class="grid">
                <tr>
                    <td>货主</td>
                    <td><input name="shId" type="hidden" value="${shipment.shId}"></td>
                    <td><input name="shStoreid" type="text" placeholder="请输入货主" class="easyui-validatebox" data-options="required:true" value="${shipment.shStoreid}"></td>
                    <td>储存费</td>
                    <td><input name="chucun" type="number" readonly="readonly" disabled="true" value="${cMoney }"/></td>元
                </tr>
                <tr>
                    <td>管理费</td>
                    <td><input name="guanli" type="number" class="easyui-validatebox" disabled="true" data-options="required:true" value="${gMoney}"></td>元
                    <td>需付总费用:</td>
                    <td><input name="countMoney" type="number" class="easyui-validatebox" disabled="true" data-options="required:true" value="${cMoney+gMoney}"></td>元
                </tr>
                <tr>
                	<td>付款金额</td>
                	<td><input name=moneyed type="number" placeholder="请输入付款金额" class="easyui-validatebox" data-options="required:true" /></td>元
                </tr>
            </table>
        </form>
    </div>
</div>
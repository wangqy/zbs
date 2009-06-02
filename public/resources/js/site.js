// JavaScript Document
// 页面框架的展开/收缩按钮使用的2个函数
function swap_class(obj,css_a,css_b) {
	if(obj.className == css_a) {
		obj.className = css_b;
	} else {
		obj.className = css_a;
	}
}

function hide_menu() {
	if(menu_container.style.display == "none") {
		$(menu_container).show();
		parent.bodyFrame.cols = "200,*";
	} else {
		$(menu_container).hide();
		parent.bodyFrame.cols = "10,*";
	}
}

// 申报端首页滚动信息使用
function scroller() {
	var currentBtn = null;
	var currentMsg = null;
	var index = 0;
	var sto = null;
	
	this.run = function() {
		toggle();
	}
	
	var msgs = $(".scroll-msg");
	if(msgs.size() > 0) {
		var btns = $("<div></div>");
		btns.addClass("scroll-msg-btns");
		msgs.each(function(i) {
			var btn = $("<a>" + (i+1) + "</a>");
			btn.click(function() {
				if(currentBtn) {
					currentBtn.removeClass("on");
					currentMsg.hide();
				}
				currentBtn = $(this);
				currentMsg = msgs.eq(i);
				currentBtn.addClass("on");
				currentMsg.show();
			});
			btns.append(btn);
		});
		$(".scroll-msg-list").append(btns);
	} else {
		$(".scroll-msg-list").addClass("scroll-msg-list-null");
		$(".scroll-msg-list").append("暂时没有系统消息");
	}
	
	var toggle = function() {
		var btns = $(".scroll-msg-btns a");
		if(index >= btns.size())
	        index = 0;
	    btns.eq(index).click();
	    index += 1;
	    clearTimeout(sto);
	    sto = setTimeout(toggle,2000);
	}
}

/**
 * 多个复选框选中一个.
 * @author Sunm
 * @since  2009-03-11
 */
function checkOne(){
	
	var currBox = event.srcElement;
	
	$("input[name='"+$(currBox).attr('name')+"']").each(function(){
		$(this).attr("checked","");
	});
	
	$(currBox).attr("checked","true");
}

/** 资金盘子文本框联动使用 */
function calValue(obj){
	var planCountyFinanceVar = document.getElementById("planCountyFinance").value;
	var planCountryFundVar = document.getElementById("planCountryFund").value;

	var dispatchCountyFinanceVar  = document.getElementById("dispatchCountyFinance").value;
	var dispatchCountryFundVar = document.getElementById("dispatchCountryFund").value;
	if(isNaN(planCountyFinanceVar) ||isNaN(planCountryFundVar)
		||isNaN(dispatchCountyFinanceVar)||isNaN(dispatchCountryFundVar)) {
		alert("请输入数字");
		obj.focus();
		return ;
	}

	if(planCountyFinanceVar==null ||planCountyFinanceVar=="") planCountyFinanceVar=0;
	if(planCountryFundVar==null ||planCountryFundVar=="") planCountryFundVar=0;
	if(dispatchCountyFinanceVar==null ||dispatchCountyFinanceVar=="") dispatchCountyFinanceVar=0;
	if(dispatchCountryFundVar==null ||dispatchCountryFundVar=="") dispatchCountryFundVar=0;
	
	document.getElementById("planFund").value =eval( planCountyFinanceVar )+ eval(planCountryFundVar );
	document.getElementById("dispatchFund").value = eval(dispatchCountyFinanceVar) + eval(dispatchCountryFundVar);

	var leftCountyFinance=eval(planCountyFinanceVar) - eval(dispatchCountyFinanceVar);
	var leftCountryFund= eval(planCountryFundVar) - eval(dispatchCountryFundVar);
	
	
	
	document.getElementById("leftCountyFinance").value = leftCountyFinance;
	document.getElementById("leftCountryFund").value =leftCountryFund;

	document.getElementById("leftFund").value = eval(document.getElementById("leftCountyFinance").value) + eval(document.getElementById("leftCountryFund").value);

}

function setProjectValue(){
	
    var resultData = $("input[name='result']").val().split(",");

    $("input[name='projectId']").val(resultData[1]);
    $("input[name='projectName']").val(resultData[2]);
    $("select[name='organ']").val(resultData[3]);
    $("select[name='projectType:type']").val(resultData[4]);
    $("select[name='projectType:type']").trigger("change");
    $("input[name='linkman']").val(resultData[6]);
    $("input[name='linktel']").val(resultData[7]);
    $("input[name='linkmobile']").val(resultData[8]);
    $("input[name='leadman']").val(resultData[9]);
    $("input[name='leadtel']").val(resultData[10]);
    $("input[name='leadmobile']").val(resultData[11]);
    $("input[name='estimateInvest']").val(resultData[12]);
    $("input[name='countyFinance']").val(resultData[13]);
    $("input[name='countryFund']").val(resultData[14]);
}





























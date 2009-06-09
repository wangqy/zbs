/**
 * 该脚本以jquery为基础，页面元素的尽量转换为jquery对象来进行处理。
 * jquery对象对属性的处理不太友好，不能在通过attr来绑定对象。
 * 此外通过attr来获取属性使代码冗长，所有脚本中许多对属性的操作是直接通过DOM对象来进行的。
 * 阅读代码时应注意对jquery对象和DOM对象的区分，例如：
 * 通过get(0)得到的是DOM对象，通过eq(0)得到的是jquery对象；
 * 而在function中jQuery(this)是jquery对象，this是DOM对象。
 */
/**
 * j-panel-toolbar渲染器
 */
var JPanelToolbarRender = function(){
    this.render = function(bar){
        bar = jQuery(bar);
        
        var ul = bar.children("ul").eq(0);
        ul.children("li").each(function(){
            jQuery(this).addClass("j-panel-toolbar-item");
            var a = jQuery(this).children("a").eq(0);
			if (a) {
				a.addClass("j-panel-toolbar-btn");
				a.addClass(jQuery(this).attr("icon"));
				
				a.hover(function(){
					jQuery(this).css("background-position-x", -15);
				}, function(){
					jQuery(this).css("background-position-x", 0);
				});
			}
        });
    }
}
/**
 * j-toolbar渲染器
 */
var JToolbarRender = function(){
    this.render = function(bar){
        bar = jQuery(bar);
        
        var ul = bar.children("ul").eq(0);
        ul.children("li").each(function(){
			if(jQuery(this).hasClass("j-page-link")) {
				jQuery(this).addClass("j-toolbar-item");
				return;
			}
			
            if (!jQuery(this).html()) {
                jQuery(this).addClass("j-toolbar-split");
                return;
            }
            jQuery(this).addClass("j-toolbar-item");
            var a = jQuery(this).children("a").eq(0);
            
            var icon = jQuery("<span></span>");
            icon.addClass(jQuery(this).attr("icon"));
            icon.addClass("j-toolbar-btn");
            if (a.html()) {
                var text = jQuery("<span></span>");
                text.html(a.html());
                a.html("");
                text.addClass("j-toolbar-btn-text");
                icon.append(text);
            }
            
            var inner = jQuery("<span></span>");
            inner.addClass("j-toolbar-btn-inner");
            inner.append(icon);
            
            var right = jQuery("<span></span>");
            right.addClass("j-toolbar-btn-right");
            right.append(inner);
            
            var left = jQuery("<span></span>");
            left.addClass("j-toolbar-btn-left");
            left.append(right);
            
            a.append(left);
            if(a.attr("disabled")) {
            	jQuery(this).attr("disabled",a.attr("disabled"));
            }
            
            jQuery(this).hover(function(){
                left.addClass("j-toolbar-btn-left-over");
                right.addClass("j-toolbar-btn-right-over");
                inner.addClass("j-toolbar-btn-inner-over");
            }, function(){
                left.removeClass("j-toolbar-btn-left-over");
                right.removeClass("j-toolbar-btn-right-over");
                inner.removeClass("j-toolbar-btn-inner-over");
            });
        });
    }
}
/**
 * j-tab渲染器。
 */
var JTabRender = function(){
    this.render = function(tab){
        tab = jQuery(tab);
        
        var ul = tab.children("ul").eq(0);
        ul.children("li").each(function(){
            jQuery(this).addClass("j-tab-item-head");
            
            var a = jQuery(this).children("a").eq(0);
            var inner = jQuery("<span></span>");
            inner.append(a.html());
            var right = jQuery("<span></span>");
            right.append(inner);
            var left = jQuery("<span></span>");
            left.append(right);
            a.html("");
            a.append(left);
            
            var content = jQuery(this).children("div").eq(0);
            if (content.html()) {
				content.addClass("j-tab-body");
				tab.append(content);
            }
            
            this.normal = function(){
                left.attr("class", "j-tab-item-head-left");
                right.attr("class", "j-tab-item-head-right");
                inner.attr("class", "j-tab-item-head-inner");
                jQuery(this).css("z-index", 0);
                content.hide();
            }
            
            this.over = function(){
                left.attr("class", "j-tab-item-head-left-over");
                right.attr("class", "j-tab-item-head-right-over");
                inner.attr("class", "j-tab-item-head-inner-over");
                jQuery(this).css("z-index", 0);
            }
            
            this.active = function(){
                left.attr("class", "j-tab-item-head-left-active");
                right.attr("class", "j-tab-item-head-right-active");
                inner.attr("class", "j-tab-item-head-inner-active");
                jQuery(this).css("z-index", 2);
                content.show();
                if (tab.active) {
                    tab.active.normal();
                }
                tab.active = this;
            }
            
            if (jQuery(this).hasClass("active")) {
                this.active();
            }
            else {
                this.normal();
            }
            
            // 设置鼠标移入、移出动作
            jQuery(this).hover(function(){
                if (tab.active != this) {
                    this.over();
                };
                            }, function(){
                if (tab.active != this) {
                    this.normal();
                }
            });
            // 设置鼠标点击动作
            jQuery(this).click(function(){
				if (tab.active != this) {
					this.active();
				}
            });
        });
        
        var head = jQuery("<div></div>");
        head.addClass("j-tab-head");
        ul.wrap(head);
        
        var line = jQuery("<div></div>");
        line.addClass("j-tab-head-line");
        ul.before(line);
        
		//alert(tab.html());
    }
}
/**
 * j-form-table渲染器
 */
var JFormTableRender = function(){
    this.render = function(table){
        table = jQuery(table);
        
        var head = table.children("thead").eq(0);
        head.addClass("j-form-table-head");
        
        table.children("tbody").each(function(){
			jQuery(this).children("tr").each(function() {
				// 处理分组行，只支持一个tbody一个分组
                if (jQuery(this).hasClass("j-form-table-group")) {
					jQuery(this).children("td").each(function() {
						jQuery(this).addClass("j-form-table-group-cell");
					});
                    // 这里只处理分组行的第一个单元格
                    var td = jQuery(this).children("td").eq(0);
                    // 设置打开和关闭的图标按钮
                    var icon = jQuery("<span class='j-form-table-group-icon'></span>");
                    icon.click(function(){
                        var tr = jQuery(this).parent().parent();
                        if (tr.get(0).opened) {
                            tr.trigger("close");
                            icon.removeClass("j-form-table-group-open");
                            icon.addClass("j-form-table-group-close");
                        }
                        else {
                            tr.trigger("open");
                            icon.removeClass("j-form-table-group-close");
                            icon.addClass("j-form-table-group-open");
                        }
                    });
                    td.prepend(icon);
                    // 设置分组行的打开和关闭动作
                    jQuery(this).bind("open", function(){
                        var rowIndex = this.rowIndex;
                        var members = jQuery(this).parent().children("tr").filter(function(){
                            return this.rowIndex > rowIndex;
                        });
                        members.each(function(){
                            jQuery(this).show();
                        });
                        this.opened = true;
                        return false;
                    });
                    
                    jQuery(this).bind("close", function(){
                        var rowIndex = this.rowIndex;
                        var members = jQuery(this).parent().children("tr").filter(function(){
                            return this.rowIndex > rowIndex;
                        });
                        members.each(function(){
                            jQuery(this).hide();
                        });
                        this.opened = false;
                        return false;
                    });
                    
                    // 初始化设置
                    if (jQuery(this).hasClass("opened")) {
                        icon.addClass("j-form-table-group-open");
                        jQuery(this).trigger("open");
                    }
                    else {
                        icon.addClass("j-form-table-group-close");
                        jQuery(this).trigger("close");
                    }
                    
                    // 分组行处理完直接返回，不进行下面对非分组行的处理
                    return;
                }
				
				if(jQuery(this).hasClass("j-form-table-split")) {
					jQuery(this).children("td").each(function() {
						jQuery(this).addClass("j-form-table-split-cell");
					});
					
					return;
				}
				
				jQuery(this).children("td:even").each(function() {
					jQuery(this).addClass("j-form-table-body-td");
					jQuery(this).addClass("j-form-table-label-td");
				});
				jQuery(this).children("td:odd").each(function() {
					jQuery(this).addClass("j-form-table-body-td");
					jQuery(this).addClass("j-form-table-input-td");
				});
				jQuery(this).children("td:last").addClass("j-form-table-label-td");
				/*
	            jQuery(this).children("td").each(function(){
	                jQuery(this).addClass("j-form-table-body-td");
	                if (this.cellIndex % 2 == 0) {
	                    jQuery(this).addClass("j-form-table-label-td");
	                }
	                else {
	                    jQuery(this).addClass("j-form-table-input-td");
	                }
	            });
	            */
			});
        });
        
        var foot = table.children("tfoot").eq(0);
        if (foot.html()) {
			foot.children("tr").each(function() {
	            jQuery(this).children("td").each(function(){
	                jQuery(this).addClass("j-form-table-foot-td");
	            });
			});
        }
    }
}
/**
 * j-form渲染器
 */
var JFormRender = function(){
    // 渲染文本框、密码框和多行文本框
    var renderText = function(text){
        text.addClass("j-form-text");
        
        // 如果设置了nofixed，则不改变其宽度
        if (!text.hasClass("nofixed")) {
            text.css("width", text.parent().width() - 14);
        }
        
        text.bind("focusin", function(){
            jQuery(this).addClass("j-form-text-focus");
            return false;
        });
        
        text.bind("focusout", function(){
            jQuery(this).removeClass("j-form-text-focus");
            return false;
        });
    }
    // 渲染下拉列表框
    var renderSelect = function(select){
        // 如果设置了nofixed，则不进行渲染。
        if (!select.hasClass("nofixed")) {
        	select.css("width",select.parent().width() - 8);
        	/*
            var box = jQuery("<div></div>");
            box.addClass("j-form-select-box");
            box.css("width", select.parent().width() - 8);
            box.css("height", select.parent().height() + 2);
            select.wrap(box);
            
            select.addClass("j-form-select");
            select.css("width", "100%");
            
            var rect = "rect(auto,auto,auto,auto)";
            if (select.attr("type") == "select-one" && select.attr("size") == 0) {
                rect = "rect(2," + (select.attr("clientWidth") - 1) + "," + (select.attr("clientHeight") - 1) + ",2)";
            }
            else {
                rect = "rect(3," + (select.attr("clientWidth") - 1) + "," + (select.attr("clientHeight") - 3) + ",3)";
            }
            select.css("clip", rect);
            */
        }
    }
    // 渲染按钮
    var renderButton = function(button){
        // 如果设置了nofixed，则不进行渲染。
        if (!button.hasClass("nofixed")) {
            button.addClass("j-form-button-out");
            
            button.mouseout(function(){
                jQuery(this).attr("class", "j-form-button-out");
            });
            button.mouseover(function(){
                jQuery(this).attr("class", "j-form-button-over");
            });
            button.mousedown(function(){
                jQuery(this).attr("class", "j-form-button-down");
            });
            button.mouseup(function(){
                jQuery(this).attr("class", "j-form-button-up");
            });
        }
    }
    // 渲染文件选择框
    var renderFile = function(file){
        // 如果设置了nofixed，则不进行渲染。
        if (!file.hasClass("nofixed")) {
            var input = jQuery("<input type='text'></input>");
            renderText(input);
            input.css("width", jQuery(file).parent().width() - 88);
            
            var button = jQuery("<input type='button'></input>");
            button.val("选取文件");
            renderButton(button);
            
            button.click(function(){
                file.attr("disabled", false);
                file.trigger("click");
                input.val(file.val());
                file.attr("disabled", true);
            });
            
            file.css("display", "none");
            file.after(button).after(input);
        }
    }
    
    // 渲染标签
    var renderLabel = function(label){
        if (label.hasClass("required")) {
            label.after("<span class='j-form-required'>*</span>");
        }
    }
    
    this.render = function(form){
        form = jQuery(form);
        
        form.find(":input").each(function(){
            // 如果form设置为nofixed，则将其下所有元素设置为nofixed。
            if (form.hasClass("nofixed")) {
                jQuery(this).addClass("nofixed");
            }
            if (this.type == "text" || this.type == "password" || this.type == "textarea") {
                renderText(jQuery(this));
            }
            if (this.type == "select-one" || this.type == "select-multiple") {
                renderSelect(jQuery(this));
            }
            if (this.type == "button" || this.type == "submit" || this.type == "reset") {
                renderButton(jQuery(this));
            }
            if (this.type == "file") {
                renderFile(jQuery(this));
            }
        });
        
        form.find("label").each(function(){
            renderLabel(jQuery(this));
        });
    }
}
/**
 * j-grid渲染器
 */
var JGridRender = function(){
    // 列头最小宽度
    var headMinWidth = 20;
    // body到grid左边距离的修正宽度值
    var offsetLeftFixedWidth = 5;
    // 鼠标定位的修正值
    var mousePosFixedWidth = 7;
    
    this.render = function(grid){
        grid = jQuery(grid);
        // 渲染放置数据的表格
        var bt = grid.children("table").eq(0);
        bt.addClass("j-grid-data-table");
        bt.attr("cellspacing", 0);
        bt.attr("cellpadding", 0);
        
        bt.children("tbody").each(function(){
            jQuery(this).children("tr").each(function(){
            	// 加入一列留空
                jQuery(this).append("<td></td>");
                
                // 处理分组行，只支持一个tbody一个分组
                if (jQuery(this).hasClass("j-grid-data-group")) {
					jQuery(this).children("td").each(function() {
						jQuery(this).addClass("j-grid-data-group-cell");
						if(!jQuery(this).html()) {
	                    	// 如果单元格无内容，补上一个空格，避免出现边框样式问题
	                    	jQuery(this).html("&nbsp;");
	                    }
					});
                    // 这里只处理分组行的第一个单元格，要求分组行的单元格合并为一个
                    var td = jQuery(this).children("td").eq(0);
                    //td.addClass("j-grid-data-group-cell");
                    // 设置打开和关闭的图标按钮
                    var icon = jQuery("<span class='j-grid-data-group-icon'></span>");
                    icon.click(function(){
                        var tr = jQuery(this).parent().parent();
                        if (tr.get(0).opened) {
                            tr.trigger("close");
                            icon.removeClass("j-grid-data-group-open");
                            icon.addClass("j-grid-data-group-close");
                        }
                        else {
                            tr.trigger("open");
                            icon.removeClass("j-grid-data-group-close");
                            icon.addClass("j-grid-data-group-open");
                        }
                    });
                    td.prepend(icon);
                    // 设置分组行的打开和关闭动作
                    jQuery(this).bind("open", function(){
                        var rowIndex = this.rowIndex;
                        var members = jQuery(this).parent().children("tr").filter(function(){
                            return this.rowIndex > rowIndex;
                        });
                        members.each(function(){
                            jQuery(this).show();
                        });
                        this.opened = true;
                        return false;
                    });
                    
                    jQuery(this).bind("close", function(){
                        var rowIndex = this.rowIndex;
                        var members = jQuery(this).parent().children("tr").filter(function(){
                            return this.rowIndex > rowIndex;
                        });
                        members.each(function(){
                            jQuery(this).hide();
                        });
                        this.opened = false;
                        return false;
                    });
                    
                    // 初始化设置
                    if (jQuery(this).hasClass("opened")) {
                        icon.addClass("j-grid-data-group-open");
                        jQuery(this).trigger("open");
                    }
                    else {
                        icon.addClass("j-grid-data-group-close");
                        jQuery(this).trigger("close");
                    }
                    
                    // 分组行处理完直接返回，不进行下面对非分组行的处理
                    return;
                }
                
                // 处理非分组行
                jQuery(this).addClass("j-grid-data-row");
                // 设置隔行样式
                if (this.rowIndex % 2 == 0) {
                    jQuery(this).addClass("j-grid-data-row-even");
                }
                else {
                    jQuery(this).addClass("j-grid-data-row-odd");
                }
                // 设置鼠标移入、移出效果
                jQuery(this).hover(function(){
                    jQuery(this).addClass("j-grid-data-row-over");
                }, function(){
                    jQuery(this).removeClass("j-grid-data-row-over");
                });
                // 渲染单元格
                jQuery(this).children("td").each(function(){
                    jQuery(this).addClass("j-grid-data-cell");
                    if(jQuery(this).html()) {
                    	// 如果单元格有内容，则加入文本层，用于处理文字超长溢出以省略号显示
                        jQuery(this).wrapInner("<span class='j-grid-data-text'></span>");
                    } else {
                    	// 如果单元格无内容，补上一个空格，避免出现边框样式问题
                    	jQuery(this).html("&nbsp;");
                    }
                });
            });
        });
        // 定义修正单元格宽度的方法
        bt.bind("fixedThWidth", function(event, cellIndex, width){
            jQuery(this).find("th").each(function(){
                if (width < headMinWidth) {
                    width = headMinWidth;
                }
                if (this.cellIndex == cellIndex) {
                    this.width = width;
                }
            });
            return false;
        });
        
        // 渲染放置表头的表格
        var ht = jQuery("<table onselectstart='return false;'></table>");
        ht.addClass("j-grid-head-table");
        ht.attr("cellspacing", 0);
        ht.attr("cellpadding", 0);
        
        // 复制数据表格中的表头，加到表头表格中
        var btHead = bt.children("thead").eq(0);
        var htHead = btHead.clone();
        // 加入一列留空
        htHead.children("tr").eq(0).append("<th></th>");
        ht.append(htHead);
        // 设置数据表格中的表头不可见（保留了元素，用来调整列宽）
        btHead.addClass("j-grid-data-head");
        
        ht.find("th").each(function(){
            jQuery(this).addClass("j-grid-head-cell");
            // 加入文本层，用于处理文字超长溢出以省略号显示
            jQuery(this).wrapInner("<span class='j-grid-head-text'></span>");
            // 根据列头修正数据单元格宽度，最后一列是留空的，不需要进行修正
            if (this.cellIndex < jQuery(this).parent().children().size() - 1) {
                bt.trigger("fixedThWidth", [this.cellIndex, this.width]);
            }
            // 创建列头的拉动条浮标
            if (this.width) {
                var resize = jQuery("<div class='j-grid-head-resize'></div>");
                resize.mousedown(function(event){
                    proxy.get(0).resize = this;
                    proxy.trigger("open", event);
                    
                });
                jQuery(this).append(resize);
            }
            // 设置列头的鼠标移入、移出效果
            jQuery(this).hover(function(){
                // 没有进行拖动的时候设置该效果，拖动时不设置此效果以防闪烁
                if (grid.children(".j-grid-head-proxy").css("display") == "none") {
                    jQuery(this).addClass("j-grid-head-cell-over");
                }
            }, function(){
                jQuery(this).removeClass("j-grid-head-cell-over");
            });
        });
        
        // 定义修正列头宽度的方法
        ht.bind("fixedThWidth", function(event, cellIndex, width){
            jQuery(this).find("th").each(function(){
                if (width < headMinWidth) {
                    width = headMinWidth;
                }
                if (jQuery(this).attr("cellIndex") == cellIndex) {
                    jQuery(this).attr("width", width);
                }
            });
            // 修正列头宽度的同时修正数据单元格的宽度
            bt.trigger("fixedThWidth", [cellIndex, width]);
            return false;
        });
        grid.prepend(ht);
        
        
        // 数据表格用层包裹，当表格内容超出时显示滚动条
        bt.wrap("<div class='j-grid-data-box'></div>");
        var box = grid.children(".j-grid-data-box").eq(0);
        if (grid.css("height") == "auto") {
            box.addClass("j-grid-data-box-auto");
        }
        // 滚动条滚动时调整表头位置跟随滚动
        box.scroll(function(){
            ht.css("left", -this.scrollLeft);
        });
        
        // 创建拖动列头使用的游标
        var proxy = jQuery("<div class='j-grid-head-proxy'></div>");
        proxy.bind("open", function(){
            this.proxyX = window.event.clientX;
            jQuery(this).css("left", window.event.clientX - grid.get(0).offsetLeft + offsetLeftFixedWidth - mousePosFixedWidth);
            jQuery(this).show();
            return false;
        });
        
        proxy.bind("close", function(event){
            this.resize = undefined;
            this.proxyX = 0;
            jQuery(this).hide();
            return false;
        });
        grid.append(proxy);
        
        // 设置拖动时将触发的Grid事件，限定拖动只在Grid内有效
        // 鼠标移动时游标跟随鼠标
        grid.mousemove(function(){
            if (proxy.css("display") == "block") {
                proxy.css("left", window.event.clientX - this.offsetLeft + offsetLeftFixedWidth - mousePosFixedWidth);
            }
            return false;
        });
        // 鼠标按键弹起时根据游标的移动距离调整列头宽度
        grid.mouseup(function(){
            var resize = proxy.get(0).resize;
            if (resize != undefined) {
                var th = resize.parentElement;
                var width = parseInt(th.width) + window.event.clientX - proxy.get(0).proxyX;
                ht.trigger("fixedThWidth", [th.cellIndex, width]);
            }
            proxy.trigger("close");
            return false;
        });
    }
}
/**
 * j-menu渲染器
 */
var JMenuRender = function() {
    var renderLi = function(li){
        // 如果li的内容为空，则表示是分割线
        if (!li.html()) {
            li.addClass("j-menu-item-split");
            return;
        }
        
        li.addClass("j-menu-list-item");
        var a = li.children("a").eq(0);
        a.addClass("j-menu-item");
        var icon = jQuery("<span></span>");
        icon.addClass("j-menu-item-icon");
        if (li.attr("icon")) {
            icon.addClass(li.attr("icon"));
        }
        a.prepend(icon);
        
        var childMenu = li.children(".j-menu").get(0);
        if (childMenu) {
            a.addClass("j-menu-item-arrow");
        }
        
        li.bind("active", function(){
            if (this.menu.active && this.menu.active == this) {
                return;
            }
            
            jQuery(this).addClass("j-menu-item-active");
            
            if (childMenu) {
                jQuery(childMenu).trigger("open", "right");
            }
            if (this.menu.active && this.menu.active != this) {
                jQuery(this.menu.active).trigger("reset");
            }
            this.menu.active = this;
            return false;
        });
        
        li.bind("reset", function(){
            jQuery(this).removeClass("j-menu-item-active");
            if (childMenu) {
                jQuery(childMenu).trigger("reset");
            }
            return false;
        });
        
        li.hover(function(){
            jQuery(this).trigger("active");
        }, function(){
            if (!childMenu) {
                this.menu.active = null;
                jQuery(this).trigger("reset");
            }
        });
    }
    
    this.render = function(menu){
        menu = jQuery(menu);
        
        // 如果菜单的display属性不是none，则该菜单将直接显示并且不会被关闭
        if (menu.css("display") != "none") {
            menu.get(0).opened = true;
        }
        
        var ul = menu.children("ul").eq(0);
        ul.children("li").each(function(){
            this.menu = menu;
            renderLi(jQuery(this));
        });
        
        menu.bind("open", function(event, model){
            var parentTop = jQuery(this).parent().offset().top;
            var parentLeft = jQuery(this).parent().offset().left;
            var parentWidth = jQuery(this).parent().width();
            var parentHeight = jQuery(this).parent().height();
			
			// 将event转成IE的event
			event = window.event;
			
            // 在父元素的右边展开
            if (model == "right") {
                if (parentTop + jQuery(this).height() > document.body.scrollHeight) {
                    jQuery(this).css("top", -(jQuery(this).height() - parentHeight));
                }
                else {
                    jQuery(this).css("top", 0);
                }
                if (parentLeft + parentWidth + jQuery(this).width() > document.body.scrollWidth) {
                    jQuery(this).css("left", -jQuery(this).width());
                }
                else {
                    jQuery(this).css("left", parentWidth);
                }
            }
			// 鼠标点击在父元素上的位置展开（要求父元素的position样式为relative或absolute）
            if (model == "mouse") {
                var x = window.event.offsetX;
                var y = window.event.offsetY;
				
                if (parentTop + y + jQuery(this).height() > document.body.scrollHeight) {
                    jQuery(this).css("top", y - jQuery(this).height());
                }
                else {
                    jQuery(this).css("top", y);
                }
                if (parentLeft + x + jQuery(this).width() > document.body.scrollWidth) {
                    jQuery(this).css("left", x - jQuery(this).width());
                }
                else {
                    jQuery(this).css("left", x);
                }
            }
			// 鼠标点击在文档的位置展开
            if (model == "client") {
                var x = window.event.clientX;
                var y = window.event.clientY;
				
                if (y + jQuery(this).height() > document.documentElement.clientHeight) {
                    jQuery(this).css("top", y - jQuery(this).height());
                }
                else {
                    jQuery(this).css("top", y);
                }
                if (x + jQuery(this).width() > document.documentElement.clientWidth) {
                    jQuery(this).css("left", x - jQuery(this).width());
                }
                else {
                    jQuery(this).css("left", x);
                }
            }
            
            jQuery(this).show("fast");
            return false;
        });
        
		// 设置菜单的重置方法
        menu.bind("reset", function(){
			// 设置菜单的激活项为空
            this.active = null;
			// 遍历调用每个菜单项元素的重置方法
            ul.children("li").each(function(){
				// 跳过是分割符的菜单项
                if (jQuery(this).html()) {
                    jQuery(this).trigger("reset");
                }
            });
			// 对于opened属性为true（在页面元素设置了display: block样式）的菜单是永远不会被关闭的
            if (!this.opened) {
                menu.hide();
            }
            return false;
        });
        
		// 点击文档时将所有菜单重置
        jQuery(document.body).click(function(){
            menu.trigger("reset");
        });
    }
}
/**
 * j-outlook-menu渲染器
 */
var JOutlookMenuRender = function(){
    this.render = function(menu){
        menu = jQuery(menu);
        var ul = menu.children("ul").eq(0);
        var itemHeight = 23;
        var itemCount = ul.children("li").size();
        ul.children("li").each(function(){
            jQuery(this).addClass("j-outlook-menu-list-item");
            
            var a = jQuery(this).children("a").eq(0);
            a.addClass("j-outlook-menu-item");
            
            var icon = jQuery("<span></span>");
            icon.addClass("j-outlook-menu-item-icon");
            if (jQuery(this).attr("icon")) {
                icon.addClass(jQuery(this).attr("icon"));
            }
            
            a.prepend(icon);
            
            var childMenu = jQuery(this).children(".j-menu").eq(0);
            
            var childMenuBox = jQuery("<div></div>");
            childMenuBox.addClass("j-outlook-child-menu-box");
            childMenuBox.css("height", menu.height() - itemCount * itemHeight);
            
            childMenu.get(0).applyElement(childMenuBox.get(0));
            
            this.close = function(){
                childMenuBox.hide("fast");
                this.opened = false;
            }
            
            this.open = function(){
                if (menu.active) {
                    menu.active.close();
                }
                this.opened = true;
                childMenuBox.show("fast");
                menu.active = this;
            }
            
            a.click(function(){
                if (this.parentElement.opened) {
                    this.parentElement.close();
                }
                else {
                    this.parentElement.open();
                }
            });
            
            if (this.opened == undefined) {
                this.close();
            }
            else {
                this.open();
            }
        });
    }
}
/**
 * j-tree渲染器
 */
var JTreeRender = function(){
    this.render = function(tree){
        tree = jQuery(tree);
        
        if (tree.attr("level") == undefined) {
            tree.attr("level", 0);
        }
        
        tree.get(0).getTopTree = function() {
        	if(this.parentLi) {
        		return this.parentLi.tree.getTopTree();
        	} else {
        		return this;
        	}
        }
        
        var ul = tree.children("ul").eq(0);
        ul.children("li").each(function(){
            //避免重复渲染
            if(jQuery(this).attr("rendered"))
              return true;
            jQuery(this).attr("rendered","1");
            jQuery(this).addClass("j-tree-node");
            this.tree = tree.get(0);
            
            if (this.opened == undefined || this.opened == "false") {
                this.opened = false;
            }
            else {
                this.opened = true;
            }
            
            var a = jQuery(this).children("a").eq(0);
            var nodeIcon = jQuery("<span></span>");
            nodeIcon.addClass("j-tree-node-icon");
            if (jQuery(this).attr("icon")) {
                nodeIcon.addClass(jQuery(this).attr("icon"));
            }
            a.prepend(nodeIcon);
            
            a.click(function() {
            	if(tree.get(0).getTopTree().selected) {
            		jQuery(tree.get(0).getTopTree().selected).removeClass("j-tree-node-selected");
            	}
            	jQuery(this).addClass("j-tree-node-selected");
            	tree.get(0).getTopTree().selected = this;
            });
            
            var foldIcon = jQuery("<span></span>");
            foldIcon.addClass("j-tree-node-fold j-tree-icon");
            if (this.leaf) {
                foldIcon.css("background", "");
            }
            else {
                foldIcon.addClass("j-tree-elbow-end-plus-nl");
            }
            foldIcon.css("margin-left", tree.attr("level") * 16);
            
            foldIcon.click(function(){
                if (this.parentElement.opened) {
                    this.parentElement.close();
                }
                else {
                    this.parentElement.open();
                }
            });
            
            jQuery(this).prepend(foldIcon);
            
            var childTree = jQuery(this).children(".j-tree").get(0);
            
            if (childTree) {
                childTree.parentLi = this;
                childTree.level = parseInt(tree.attr("level")) + 1;
            }
            
            a.hover(function(){
                jQuery(this).addClass("j-tree-node-over");
            }, function(){
                jQuery(this).removeClass("j-tree-node-over");
            });
            
            this.open = function(){
                if (childTree) {
                    jQuery(childTree).show();
                }
                this.opened = true;
                foldIcon.removeClass("j-tree-elbow-end-plus-nl");
                foldIcon.addClass("j-tree-elbow-end-minus-nl");
                if (tree.get(0).parentLi) {
                    tree.get(0).parentLi.open();
                }
            }
            this.close = function(){
                if (childTree) {
                    jQuery(childTree).hide();
                }
                this.opened = false;
                foldIcon.removeClass("j-tree-elbow-end-minus-nl");
                foldIcon.addClass("j-tree-elbow-end-plus-nl");
            }
            
            if (this.opened) {
                this.open();
            }
            else {
                this.close();
            }
            
            if(this.selected == "true") {
            	a.click();
            }
        });
    }
}

var JSearchRender = function() {
	this.render = function(search){
		search = jQuery(search);
		search.hide();
	}
}

var JRenderManager = function(){
    this.renders = new Array();
    
    this.regRender = function(renderName, renderInstance){
        this.renders.push({
            "name": renderName,
            "instance": renderInstance
        });
    }
    
    this.regRender("j-panel-toolbar", new JPanelToolbarRender());
    this.regRender("j-form-table", new JFormTableRender());
    this.regRender("j-form", new JFormRender());
    this.regRender("j-tab", new JTabRender());
    this.regRender("j-menu", new JMenuRender());
    this.regRender("j-outlook-menu", new JOutlookMenuRender());
    this.regRender("j-toolbar", new JToolbarRender());
    this.regRender("j-grid", new JGridRender());
    this.regRender("j-tree", new JTreeRender());
	this.regRender("j-search", new JSearchRender());
    
    this.render = function(el){
        var render = this.getRender(el);
        if (render != null) {
            render.render(el);
        }
    }
    
    this.getRender = function(el){
        for (var i = 0; i < this.renders.length; i++) {
            if (jQuery(el).hasClass(this.renders[i].name)) {
                return this.renders[i].instance;
            }
        }
        return null;
    }
}
renderManager = new JRenderManager();

function renderAll(){
    jQuery("form,div,span,table").each(function(){
        renderManager.render(this);
    });
}

jQuery(document).ready(function(){
    renderAll();
});

/**
 * 层模拟窗口
 */
var JWindow = function(){
    this.defaultWindowWidth = 600;
    this.defaultWindowHeight = 400;
    this.fixedWidth = 14;
    this.fixedHeight = 33;
    
    var createWindow = function(){
        var wd = jQuery("<div></div>");
        wd.addClass("j-window");
        //wd.width(jQuery(document).width());
        //wd.height(jQuery(document).height());
        
        var frame = jQuery("<iframe frameborder='no' scrolling='no' class='j-window-frame'></iframe>");
        wd.append(frame);
        
        var box = jQuery("<div></div>");
        box.addClass("j-window-box");
        wd.append(box);
        
        var head = jQuery("<div class='j-window-tl'><div class='j-window-tr'><div class='j-window-tc'></div></div></div>");
        var text = jQuery("<div class='j-panel-text'></div>");
        var tcBar = jQuery("<div class='j-panel-toolbar'><ul><li icon='j-win-icon j-win-close'><a></a></li></ul></div>");
        
        tcBar.find("a").eq(0).click(function(){
            wd.trigger("close");
        });
        renderManager.render(tcBar);
        head.find(".j-window-tc").eq(0).append(text).append(tcBar);
        
        wd.bind("title", function(event, title){
            text.text(title);
            return false;
        });
        box.append(head);
        
        var body = jQuery("<div class='j-window-ml'><div class='j-window-mr'><div class='j-window-mc'></div></div></div>");
        wd.bind("content", function(event, content){
            var mc = body.find(".j-window-mc").eq(0);
            mc.empty();
            mc.append(content);
            return false;
        });
        box.append(body);
        
        var foot = jQuery("<div class='j-window-bl'><div class='j-window-br'><div class='j-window-bc'></div></div></div>");
        box.append(foot);
        
        wd.bind("position", function(event, width, height){
            var top = (document.documentElement.clientHeight - height) / 2 -50;
            var left = (document.documentElement.clientWidth - width) / 2;
            box.css({
                "width": width,
                "height": height,
                "top": top,
                "left": left
            });
            return false;
        });
        
        wd.bind("close", function(){
            jQuery(this).hide("fast");
            return false;
        });
        
        wd.bind("open", function(){
        	jQuery(this).show("fast");
        	return false;
        });
        
        wd.hide();
        return wd;
    }
    
    this.openWindow = function(title, url, width, height){
        if (!width) {
            width = this.defaultWindowWidth;
        }
        if (!height) {
            height = this.defaultWindowHeight;
        }
        
        var wd = jQuery("#j-window");
        if (!wd.html()) {
            wd = createWindow();
            wd.attr("id", "j-window");
            jQuery(document.body).append(wd);
        }
        
        var content = jQuery("<iframe frameborder='0' scrolling='no' src='" + url + "'></iframe>");
        content.width(width - this.fixedWidth);
        content.height(height - this.fixedHeight);
        content.get(0).wd = wd;
        wd.trigger("content", content);
        wd.trigger("title", title);
        wd.trigger("position", [width, height]);
        wd.trigger("open");
    }
    
    this.openDiv = function(contentId){
        var wd = jQuery("#" + contentId + "-window");
        if (!wd.html()) {
            var content = jQuery("#" + contentId);
            content.show();
            
            wd = createWindow();
            wd.attr("id", contentId + "-window");
            // 如果打开的层在一个form下面，则包装后仍添加在该form下面；如果不在一个表单下面，则直接添加在document下面；
            // 这样避免由于对层的包装而使form不能正确提交
            var form = content.parents("form:first");
            if(form.html()) {
            	form.append(wd);
            } else {
            	jQuery(document.body).append(wd);
            }
            
            if (content.attr("caption")) {
                wd.trigger("title", content.attr("caption"));
            }
            else {
                wd.trigger("title", "查询");
            }
            
            wd.trigger("position", [content.width() + this.fixedWidth, content.height() + this.fixedHeight]);
            wd.trigger("content", content);
        }
        wd.trigger("open");
    }
}

function closeWindow(){
    if (window.frameElement.wd) 
        window.frameElement.wd.trigger("close");
}

function newWindow(title, url, width, height){
    var jwindow = new JWindow();
    jwindow.openWindow(title, url, width, height);
}

function newDiv(contentId){
    var jwindow = new JWindow();
    jwindow.openDiv(contentId);
}

function closeDiv(contentId){
    var wd = jQuery("#" + contentId + "-window");
    if (wd.html()) {
        wd.trigger("close");
    }
}

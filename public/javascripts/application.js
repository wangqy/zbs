// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var j = jQuery.noConflict();

j(document).ready(function(){
  //focus
  j(":input[is_focus]").focus();

  //facebox lightbox(avoid enter key triggle another facebox)
  j('a[rel*=facebox]').focus(function(){j(this).blur();});
  j('a[rel*=facebox]').facebox(); 

  j(document).bind('reveal.facebox', function(){
    //focus
    j(":input[is_focus]").focus();
  });

  var SubMenu = Class.create({
    initialize: function(li) {
      if(!$(li)) return;
      this.trigger = $(li).down('em');
      if(!this.trigger) return;
      this.menu = $(li).down('ul');
      this.trigger.observe('click', this.respondToClick.bind(this));
      document.observe('click', function(){ this.menu.hide();}.bind(this));
    },
                  
    respondToClick: function(event) {
      event.stop();
      $$('ul.submenu').without(this.menu).invoke('hide');
      this.menu.toggle();
    }
  });

  new SubMenu("t-menu");

  //calendar
  _translations = {
    "OK": "OK",
    "Now": "Now",
    "Today": "Today",
    "Clear": "清空"
  };
  Date.weekdays = $w("日 一 二 三 四 五 六");
  Date.months = $w("一月 二月 三月 四月 五月 六月 七月 八月 九月 十月 十一月 十二月");


});

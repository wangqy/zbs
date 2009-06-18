// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var j = jQuery.noConflict();

j(document).ready(function(){
  //focus
  j(":input[is_focus]").focus();

  //calendar
  _translations = {
    "OK": "OK",
    "Now": "Now",
    "Today": "Today",
    "Clear": "清空"
  };
  Date.weekdays = $w("日 一 二 三 四 五 六");
  Date.months = $w("一月 二月 三月 四月 五月 六月 七月 八月 九月 十月 十一月 十二月");

  //wav player
  j('.player').toggle(function(){
    j(this).addClass('play_stop');
    j('.player').removeClass('play_start');
    j('#player').html("<bgsound src='"+j(this).attr("wav_url")+"' loop='infinite'>");
  },function(){
    j(this).addClass('play_start');
    j('.player').removeClass('play_stop');
    j('#player').html("");
  });

});

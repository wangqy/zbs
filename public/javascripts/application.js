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
});

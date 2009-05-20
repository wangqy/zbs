function showMinus(logo_plus_id, logo_minus_id, sub_id){
  j('#' + logo_plus_id + ' img').hide();
  j('#' + logo_minus_id + ' img').show();
  j('#' + sub_id).show();
}

function showPlus(logo_plus_id, logo_minus_id, sub_id){
  j('#' + logo_plus_id + ' img').show();
  j('#' + logo_minus_id + ' img').hide();
  j('#' + sub_id).html('').hide();
}

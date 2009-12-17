$(function() {
  $(".pagination a").live("click", function() {
    $(".pagination").html("Page is loading...");
    $.get(this.href, null, null, "script");
    return false;
  });
});

 jQuery.ajaxSetUp({
    'beforeSend': function (xhr) {xhr.setRequestHeader('Accept', 'text/javascript')}
 });  
  // Initial page load b/f Turbolinks kicks in
$(function() {
  wireSubscribeForm();
});

var wireSubscribeForm = function() {

  var submitSearch = function() {
    form = $("#top_search_form");
    $.pjax({
      url: form.attr('action') + '?' + form.serialize(),
      container: '#results',
      timeout: 2500
    });
    return false;
  };

  // $(window).bind('pjax:start', function() {
  //   $("#search-error").hide();
  //   $(".indicator").css("visibility", "visible");
  // });

  // $(window).bind('pjax:complete', function() {
  //   $(".indicator").css("visibility", "hidden");
  // });

  // $(window).bind('pjax:success', function() {
  //   $("#search-error").hide();
  //   displayResults();
  // });

  // $(window).bind('pjax:timeout', function() {
  //   searchTimeout();
  //   return false;
  // });

  // $(window).bind('pjax:error', function() {
  //   searchError();
  //   return false;
  // });
};
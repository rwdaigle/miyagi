$(function() {

  // Borrowed from Gisted.
  var haltEvent = function(event) {
    event.stopPropagation();
    event.preventDefault();   
  };

  // Borrowed from Dev Center. Thanks, Raul!
  var trackLinks = function() {

    var isExternalUrl = function(url) {
      var absoluteUrlRegExp = RegExp(/^https?:\/\//);
      return (url.indexOf(document.location.host) == -1) && absoluteUrlRegExp.test(url)
    };

    $("a").click(function(event) {
      $this = $(this);
      if(isExternalUrl($this.attr("href"))) {
        var context = $this.attr("link-context");
        window.location = "/l?url=" + $this.attr("href") + (context ? "&context=" + context : "");
        haltEvent(event);
      }
    });
  };

  trackLinks();
});
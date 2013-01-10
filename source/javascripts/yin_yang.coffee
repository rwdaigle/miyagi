$ ->
  
  class YinYang
    @init: ->
      $('#yin_yang').on 'click', ->
        yy.toggle()
      
      if $('body').hasClass('night')
        @rotate()
    
    @toggle: ->
      $('body').toggleClass('night')
      @rotate()
      $.setCookie('night', $('body').hasClass('night'))
      
    @rotate: ->
      $("#yin_yang .container").css({ rotate: '+=180' });
    
  window.yy = YinYang
  
  yy.init()
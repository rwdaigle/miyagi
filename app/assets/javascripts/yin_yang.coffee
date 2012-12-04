$ ->
  
  class YinYang
    @toggle: ->
      $('body').toggleClass('night')
      $.setCookie('night', $('body').hasClass('night'))
    
  window.yy = YinYang
  
  $('#yin_yang').on 'click', ->
    yy.toggle()
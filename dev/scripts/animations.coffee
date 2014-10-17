define ['jquery', 'TweenMax', 'angular', 'angular-animate'], ($, TweenMax) ->
  app = angular.module 'graph.animations', ['ngAnimate']

  app.animation '.toggle-prompt', ->
    animate =
      leave: (ele, done) ->
        TweenMax.to ele, 0.3, {autoAlpha: 0, ease: Power3.easeOut, onComplete: done}
        TweenMax.to ele, 0.3, {autoAlpha: 0, ease: Power3.easeOut, delay: 1}
        return
      enter: (ele, done) ->
        TweenMax.fromTo ele, .6, {autoAlpha: 0}, {autoAlpha: 1, delay: 1, onComplete: done}
        return

  app.animation '.toggle-graph', ->
    animate =
      leave: (ele, done) ->
        TweenMax.to ele, 0.3, {autoAlpha: 0, y: 40, ease: Power3.easeOut, onComplete: done}
        return
      
      enter: (ele, done) ->
        TweenMax.fromTo $(ele).find('.y-axis'), .6, {height: 0}, {height: '100%', ease: Power3.easeOut, onComplete: done}
        TweenMax.fromTo $(ele).find('.data-item p'), .3, {autoAlpha: 0}, {autoAlpha: 1}
            
        $(ele).find('.data-item').each (i) ->
          time = .9
          delay = i/40

          # animation of KEYS
          $key = $(this).find('.key')
          TweenMax.fromTo $key, time,
            {autoAlpha: 0, x: 100},
            {autoAlpha: 1, x: 0, ease: Power3.easeInOut, delay: delay}
            
          # animation of VALUES
          $value = $(this).find('.value')
          width = valueToWidth $value.data('width')
          TweenMax.fromTo $value, time,
            {width: 0},
            {width: width, autoAlpha: 1, ease: Power3.easeInOut, delay: delay}
        return

  # ratio
  valueToWidth = (value) ->
    value * 380 / 6000

  return app

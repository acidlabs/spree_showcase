$ ->
   $(document).on 'ready', ->
    if $('#flex_config').length <= 0
      return

    $('.flexslider').flexslider({
      animation:         $("#flex_config span[data-type]").data('type'),            # String: Select your animation type, "fade" or "slide"
      slideDirection:    "horizontal",                                              # String: Select the sliding direction, "horizontal" or "vertical"
      slideshow:         $("#flex_config span[data-slideshow]").data('slideshow'),  # Boolean: Animate slider automatically
      slideshowSpeed:    $("#flex_config span[data-speed]").data('speed'),          # Integer: Set the speed of the slideshow cycling, in milliseconds
      animationDuration: $("#flex_config span[data-duration]").data('duration'),    # Integer: Set the speed of animations, in milliseconds
      directionNav:      false,                                                     # Boolean: Create navigation for previous/next navigation? (true/false)
      controlNav:        true,                                                      # Boolean: Create navigation for paging control of each clide? Note: Leave true for manualControls usage
      keyboardNav:       true,                                                      # Boolean: Allow slider navigating via keyboard left/right keys
      mousewheel:        false,                                                     # Boolean: Allow slider navigating via mousewheel
      prevText:          "Previous",                                                # String: Set the text for the "previous" directionNav item
      nextText:          "Next",                                                    # String: Set the text for the "next" directionNav item
      pausePlay:         false,                                                     # Boolean: Create pause/play dynamic element
      pauseText:         'Pause',                                                   # String: Set the text for the "pause" pausePlay item
      playText:          'Play',                                                    # String: Set the text for the "play" pausePlay item
      randomize:         $("#flex_config span[data-randomize]").data('randomize'),  # Boolean: Randomize slide order
      slideToStart:      0,                                                         # Integer: The slide that the slider should start on. Array notation (0 = first slide)
      animationLoop:     $("#flex_config span[data-loop]").data('loop'),            # Boolean: Should the animation loop? If false, directionNav will received "disable" classes at either end
      pauseOnAction:     true,                                                      # Boolean: Pause the slideshow when interacting with control elements, highly recommended.
      pauseOnHover:      $("#flex_config span[data-pause]").data('pause'),          # Boolean: Pause the slideshow when hovering over slider, then resume when no longer hovering
      controlsContainer: '.flex-container',                                         # Selector: Declare which container the navigation elements should be appended too. Default container is the flexSlider element. Example use would be ".flexslider-container", "#container", etc. If the given element is not found, the default action will be taken.
      manualControls:    '.custom-controls li a',                                   # Selector: Declare custom control navigation. Example would be ".flex-control-nav li" or "#tabs-nav li img", etc. The number of elements in your controlNav should match the number of slides/tabs.
      start:             ->,                                                        # Callback: function(slider) - Fires when the slider loads the first slide
      before:            ->,                                                        # Callback: function(slider) - Fires asynchronously with each slider animation
      after:             ->,                                                        # Callback: function(slider) - Fires after each slider animation completes
      end:               ->                                                         # Callback: function(slider) - Fires when the slider reaches the last slide (asynchronous)
    });
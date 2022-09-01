(function ($) {
    'use strict';

    $(document).on('ready', function () {
        // -----------------------------
        //  On Scroll Resize Nav
        // -----------------------------
        $(document).on('scroll', function() {
            if($(document).scrollTop()>100) {
                $('.main-nav').removeClass('large').addClass('small');
            } else {
                $('.main-nav').removeClass('small').addClass('large');
            }
        });
        // -----------------------------
        //  On Click Smooth scrool
        // -----------------------------
         $('.scrollTo').on('click', function(e) {
             e.preventDefault();
             var target = $(this).attr('href');
             $('html, body').animate({
               scrollTop: ($(target).offset().top)
             }, 500);
          });
        // -----------------------------
        //  Testimonial Slider
        // -----------------------------
         $('.testimonial-slider').slick({
            responsive: [
                {
                  breakpoint: 768,
                  settings: {
                    arrows: false
                  }
                }
            ]
         });
        // -----------------------------
        //  Screenshot Slider
        // -----------------------------
        $('.screenshot-slider').slick({
            dots: true,
            slidesToShow: 3,
            centerMode: true,
            infinite: false,
            responsive: [
                {
                  breakpoint: 768,
                  settings: {
                    arrows: false
                  }
                }
            ]
         });
        // -----------------------------
        //  Video Replace
        // -----------------------------
        $('.video-box span.icon').click(function() {
            var video = '<iframe allowfullscreen src="' + $(this).attr('data-video') + '"></iframe>';
            $(this).replaceWith(video);
        });
        // -----------------------------
        //  Team Progress Bar
        // -----------------------------
        $('.team').waypoint(function(){
            $('.progress').each(function(){
                $(this).find('.progress-bar').animate({
                    width:$(this).attr('data-percent')
                });
            });
            this.destroy();
        },{
            offset:100
        });

    });


})(jQuery);
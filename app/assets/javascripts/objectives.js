(function($) {

  $(document).on('page:change', function() {

    if ( $('.objectives.index').length === 0 ) { return; }

    var $panels = $('.panel');

    var currentKFA = '';
    
    $panels.each(function(idx, panel) {
      var $panel = $(panel);
      var kfaLabel = $panel.find('.kfa-name').text();
      if (currentKFA !== kfaLabel) {
        $panel.parent().before('<div class="col-xs-12"><h4>' + kfaLabel + '</h4></div>');
        currentKFA = kfaLabel;
      }
    });

  });


})(jQuery);
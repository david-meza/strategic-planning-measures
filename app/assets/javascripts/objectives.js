(function($) {

  $(document).on('page:change', function() {

    var $usedBackButton, $panels, currentKFA;

    $usedBackButton = $('#page_is_dirty');

    if ( $('.objectives.index').length === 0 || Number($usedBackButton.val()) > 0 ) { return; }

    $usedBackButton.val(1);
    $panels = $('.panel');
    currentKFA = '';
    
    $panels.each(function(idx, panel) {
      var $panel = $(panel);
      var kfaLabel = $panel.attr('data-objective-kfa');
      if (currentKFA !== kfaLabel) {
        $panel.parent().before('<div class="col-xs-12"><h4 class="kfa-subheader text-center">' + kfaLabel + '</h4></div>');
        currentKFA = kfaLabel;
      }
    });

  });


})(jQuery);
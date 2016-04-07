(function($) {

  jQuery.fn.sortDomElements = (function() {
      return function(comparator) {
          return Array.prototype.sort.call(this, comparator).each(function(i) {
                this.parentNode.appendChild(this);
          });
      };
  })();

  $(document).on('page:change', function() {

    $usedBackButton = $('#page_is_dirty');

    if ( $('.performance_measures.index').length === 0 || Number($usedBackButton.val()) > 0 ) { return; }

    $usedBackButton.val(1);

    $('.row.flex-row').children().sortDomElements(function(a,b){
      var akey = $(a).children().first();
      var bkey = $(b).children().first();
      
      var akfaLabel = akey.attr("data-objective-kfa");
      var bkfaLabel = bkey.attr("data-objective-kfa");

      var aObjective = akey.attr("data-objective-name");
      var bObjective = bkey.attr("data-objective-name");

      if (akfaLabel > bkfaLabel) {
        return 1;
      }
      if (akfaLabel < bkfaLabel) {
        return -1;
      }

      return 0;
    });

    var currentKFA = '';
    var $panels = $('.panel');
    
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
var EventSystem = (function() {
  
  var self = this;

  self.queue = {};

  return {
    publish: function (event, options) {
      options = options || {};
      var queue = self.queue[event];

      if (typeof queue === 'undefined') {
        return false;
      }

      queue.forEach( function(fn) {
        fn(options);
      });

      return true;
    },
    
    subscribe: function(event, callback) {
      if (typeof self.queue[event] === 'undefined') {
        self.queue[event] = [];
      }

      self.queue[event].push(callback);
    }
  };

}());
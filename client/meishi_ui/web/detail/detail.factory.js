define(function() {

  app_cached_providers
    .$provide
    .factory('bizcard', ['$q', '$http', '$filter',
      function($q, $http, $filter) {
        var loading = true;

        return {
          getItem: function(id) {
            var bcs = angular.fromJson(localStorage.getItem("demo.bizcards"));
            if (id == 'owner') return $filter('filter')(bcs, {owner: true })[0];
            return $filter('filter')(bcs, {id: id })[0];
          },

        };
      }
    ]);

});
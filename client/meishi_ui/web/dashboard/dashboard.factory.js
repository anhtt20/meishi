define(function() {

  app_cached_providers
    .$provide
    .factory('dash', ['$q', '$http', '$filter',
      function($q, $http, $filter) {
        var loading = true;

        return {
          getLastCreate: function() {
            var bcs = angular.fromJson(localStorage.getItem("demo.bizcards"));
            _identity = angular.fromJson(localStorage.getItem("demo.identity"));
            return bcs;
          },
          getTopRank: function(){
            return [
              {
                name: 'top1'
              },
              {
                name: 'top2'
              },
              {
                name: 'top3'
              }
            ];
          }

        };
      }
    ]);

});
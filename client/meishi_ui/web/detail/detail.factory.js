define(function() {

  app_cached_providers
    .$provide
    .factory('bizcard', ['$q', '$http', '$filter', '$mdDialog', '$state',
      function($q, $http, $filter, $mdDialog, $state) {
        var loading = true;

        function pushError(data) {
          if (data.status == '401') {
            $state.go('signin');
          } else {
            var confirm = $mdDialog.confirm()
              .title('通知')
              .textContent(data.message)
              .ok('完了');
            $mdDialog.show(confirm)
              .then(function() {
                  $state.go('filter', {
                    option: 'all'
                  });
                },
                function() {
                  $state.go('filter', {
                    option: 'all'
                  });
                });
          }
        };

        return {
          getItem: function(id, next) {
            $http.get(api_root + 'business_cards/' + id)
              .success(function(data, status, headers, config) {
                //console.debug(data);
                next(data);
              })
              .error(function(data, status, headers, config) {
                pushError(data);
              });
          },
          destoyItem: function(id, next) {
            $http.delete(api_root + 'business_cards/' + id)
              .success(function(data, status, headers, config) {
                //console.debug(data);
                next(data);
              })
              .error(function(data, status, headers, config) {
                pushError(data);
              });
          }
        };

      }
    ]);

});
define(function() {

  app_cached_providers
    .$provide
    .factory('filter', ['$q', '$http', '$filter', '$httpParamSerializer','$mdDialog', '$state',
      function($q, $http, $filter, $httpParamSerializer, $mdDialog, $state) {

        function pushError(message) {
          var confirm = $mdDialog.confirm()
            .title('通知')
            .textContent(message)
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
        };

        return {
          fetchAll: function(condition, next) {
            $http.get(api_root + 'business_cards', { params: condition })
              .success(function(data, status, headers, config) {
                //console.debug(data);
                next(data);
              })
              .error(function(data, status, headers, config) {
                pushError(data.message);
              });
          }
        };
      }
    ]);

});
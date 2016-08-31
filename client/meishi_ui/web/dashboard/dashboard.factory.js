define(function() {

  app_cached_providers
    .$provide
    .factory('dash', ['$q', '$http', '$filter','$mdDialog', '$state',
      function($q, $http, $filter, $mdDialog, $state) {

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
          getLastCreate: function(next) {
            condition = {
              my_card: false,
              search_by: 'business_cards.name',
              page: 1,
              page_size: 6,
              keyword: '',
              order_by: 'business_cards.created_at',
              asc: 0
            };
            $http.get(api_root + 'business_cards', { params: condition })
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
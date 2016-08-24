define(function() {

  app_cached_providers
    .$provide
    .factory('dash', ['$q', '$http', '$filter','$mdDialog', '$state',
      function($q, $http, $filter, $mdDialog, $state) {

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
                pushError(data.message);
              });
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
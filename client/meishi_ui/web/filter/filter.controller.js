define(function() {

  app_cached_providers
    .$controllerProvider
    .register('filterCtrl', ['$stateParams', '$rootScope', '$scope', '$state', 'filter', 　'$mdSidenav', '$timeout',
      function($stateParams, $rootScope, $scope, $state, filter, $mdSidenav, $timeout) {
        //Title
        $rootScope.Title = "ホアンホアン｜検索";

        //Filter properties
        $scope.condition = {
          my_card: $stateParams.option == 'me',
          search_by: 'business_cards.name',
          page: 1,
          page_size: 5,
          keyword: '',
          order_by: 'business_cards.created_at',
          asc: 0
        };

        $scope.i_path = function(domain, path) {
          return api_static + domain + path;
        };

        $scope.bizcards;
        filter.fetchAll($scope.condition, function(data) {
          if (data.length < 5) $scope.nomore = true;
          $scope.bizcards = data;
        });

        //Functions
        $scope.search = function() {
          filter.fetchAll($scope.condition, function(data) {
            if (data.length < 5) $scope.nomore = true;
            $scope.bizcards = data;
          });
        }

        $scope.loadMore = function(){
          $scope.condition.page += 1;
          console.log($scope.condition);
          filter.fetchAll($scope.condition, function(data) {
            if (data.length < 5) $scope.nomore = true;
            for (var i = 0; i < data.length; i++) {
              console.log(data[i]);
              $scope.bizcards.push(data[i]);
            }
          });
        }

        //Open setting silde
        $scope.toggleSlide = function() {
          $mdSidenav('slide')
            .toggle();
        }
      }
    ]);

});
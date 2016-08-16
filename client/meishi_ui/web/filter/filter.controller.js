define(function() {

  app_cached_providers
    .$controllerProvider
    .register('filterCtrl', ['$stateParams', '$scope', '$state', 'filter',　'$mdSidenav', '$timeout',
      function($stateParams, $scope, $state, filter, $mdSidenav, $timeout) {
        $scope.bizcards = filter.fetchAll($stateParams.option);

        $scope.searchBy = 0;

        $scope.search = function(){
          console.log($scope.searchBy);
        }


        //Open setting silde
        $scope.toggleSlide = function() {
          $mdSidenav('search-config')
            .toggle();
        }
      }
    ]);

});
define(function() {

  app_cached_providers
    .$controllerProvider
    .register('dashboardCtrl', ['$rootScope', '$scope', '$state', 'dash',
      function($rootScope, $scope, $state, dash) {
        
        $scope.topLastFive = dash.getLastCreate();

        $scope.topRank = dash.getTopRank();

      }
    ]);

});
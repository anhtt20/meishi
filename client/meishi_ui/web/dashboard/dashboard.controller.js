define(function() {

  app_cached_providers
    .$controllerProvider
    .register('dashboardCtrl', ['$rootScope', '$scope', '$state', 'dash',
      function($rootScope, $scope, $state, dash) {
        
        $rootScope.Title = "ホアンホアン｜ダッシュボード";

        $scope.topLastFive;

        dash.getLastCreate(function(data){
          $scope.topLastFive = data;
        });

        $scope.i_path = function(domain, path) {
          return api_static + domain + path;
        };

      }
    ]);

});
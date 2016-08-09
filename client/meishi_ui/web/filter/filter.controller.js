define(function() {

  app_cached_providers
    .$controllerProvider
    .register('filterCtrl', ['$stateParams', '$scope', '$state', 'filter',
      function($stateParams, $scope, $state, filter) {
        $scope.bizcards = filter.fetchAll($stateParams.option);
      }
    ]);

});
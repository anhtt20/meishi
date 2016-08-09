define(function() {

  app_cached_providers
    .$controllerProvider
    .register('detailCtrl', ['$stateParams', '$scope', '$state', 'bizcard',
      function($stateParams, $scope, $state, bizcard) {
        $scope.item = bizcard.getItem($stateParams.index);
      }
    ]);

});
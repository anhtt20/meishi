define(function() {

  app_cached_providers
    .$controllerProvider
    .register('registerCtrl', ['$rootScope', '$scope', '$state', 'principal', '$http', '$mdDialog',
      function($rootScope, $scope, $state, principal, $http, $mdDialog) {

        $rootScope.Title = "ホアンホアン｜登録";

        function pushError(message) {
          var confirm = $mdDialog.confirm()
            .title('通知')
            .textContent(message)
            .ok('完了');
          $mdDialog.show(confirm);
        };

        $scope.register = function(user) {
          $http({
              method: 'POST',
              url: api_root + 'sign_up',
              data: angular.toJson(user)
            }).success(function(data, status, headers, config) {
              $state.go('signin');
            })
            .error(function(data, status, headers, config) {
              // called asynchronously if an error occurs
              // or server returns response with an error status.
              pushError(data.message)
            });
        }
      }
    ]);

});
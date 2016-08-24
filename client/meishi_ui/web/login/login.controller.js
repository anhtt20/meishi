define(function() {

  app_cached_providers
    .$controllerProvider
    .register('loginCtrl', ['$rootScope', '$scope', '$state', 'principal', '$http',
      function($rootScope, $scope, $state, principal, $http) {

        $rootScope.Title = "ホアンホアン｜ログイン";

        $scope.login = function(user) {
          $http({
              method: 'POST',
              url: api_root + 'sign_in',
              data: angular.toJson(user)
            }).success(function(data, status, headers, config) {
              console.debug(data);
              principal.authenticate({
                name: data.email,
                roles: [headers('hh-roles')],
                token: headers('hh-token')
              });

              $rootScope.uid = data.email;

              if ($scope.returnToState) $state.go($scope.returnToState.name, $scope.returnToStateParams);
              else $state.go('dashboard');
            })
            .error(function(data, status, headers, config) {
              // called asynchronously if an error occurs
              // or server returns response with an error status.
              console.log(data);
            });
        }
      }
    ]);

});
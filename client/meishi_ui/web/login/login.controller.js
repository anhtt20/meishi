define(function() {

  app_cached_providers
    .$controllerProvider
    .register('loginCtrl', ['$rootScope', '$scope', '$state', 'principal',
      function($rootScope, $scope, $state, principal) {
        $scope.message = "It works - from Login";

        $scope.$parent.isLogined = false;

        // when the user logs in, fetch the posts
        // $rootScope.$on('auth:login-success', function(ev, user) {
        //   $scope.message = 'OK';
        //   principal.authenticate({
        //     name: user.email,
        //     roles: ['User']
        //   });
        //   console.log(user);

        //   $scope.$parent.isLogined = true;

        //   if ($scope.returnToState) $state.go($scope.returnToState.name, $scope.returnToStateParams);
        //   else $state.go('dashboard');
        // });

        $scope.login = function(user) {
          principal.authenticate({
            name: user.email,
            roles: ['User']
          });
          console.log(user);

          $rootScope.uid = user.email;

          if ($scope.returnToState) $state.go($scope.returnToState.name, $scope.returnToStateParams);
          else $state.go('dashboard');
        }

      }
    ]);

});
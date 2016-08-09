define(function() {

  angular.module('meishi')
    .controller('appController', ['$rootScope', '$scope', '$state', 'principal',
      function($rootScope, $scope, $state, principal) {
        //Signout
        $scope.signout = function() {
          console.debug('OUT');
          principal.authenticate(null);
          $state.go('signin');
        };

        _identity = angular.fromJson(localStorage.getItem("demo.identity"));

        $rootScope.uid = _identity.name;

        // when the user logs out, remove the posts
        $rootScope.$on('auth:logout-success', function(ev) {
          $scope.title = 'Logout';
        });
      }
    ]);

});
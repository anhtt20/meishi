define(function() {

  angular.module('meishi')
    .controller('appController', ['$rootScope', '$scope', '$state', 'principal', '$http',
      function($rootScope, $scope, $state, principal, $http) {
        //Signout
        $scope.signout = function() {
           $http({
              method: 'DELETE',
              url: api_root + 'sign_out'
            }).success(function(data, status, headers, config) {
              principal.authenticate(null);
              $state.go('signin');
            })
            .error(function(data, status, headers, config) {
              // called asynchronously if an error occurs
              // or server returns response with an error status.
              console.log(data);
            });
          
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
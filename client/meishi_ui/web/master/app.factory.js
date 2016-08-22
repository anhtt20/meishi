define(function() {

  angular.module('meishi')
    .factory('principal', ['$q', '$http', '$timeout', '$cookies',
      function($q, $http, $timeout, $cookies) {
        var _identity = undefined,
          _authenticated = false;

        return {
          isIdentityResolved: function() {
            return angular.isDefined(_identity);
          },
          isAuthenticated: function() {
            return _authenticated;
          },
          isInRole: function(role) {
            if (!_authenticated || !_identity.roles) return false;

            return _identity.roles.indexOf(role) != -1;
          },
          isInAnyRole: function(roles) {
            if (!_authenticated || !_identity.roles) return false;

            for (var i = 0; i < roles.length; i++) {
              if (this.isInRole(roles[i])) return true;
            }

            return false;
          },
          authenticate: function(identity) {
            _identity = identity;
            _authenticated = identity != null;

            if (identity) {
              $cookies.putObject('meishi.identity', angular.toJson(identity));
              $http.defaults.headers.common.Authorization = 'Token token=' + identity.token;
            }
            else $cookies.remove('meishi.identity');
          },
          identity: function(force) {
            var deferred = $q.defer();

            if (force === true) _identity = undefined;

            // check and see if we have retrieved the identity data from the server. if we have, reuse it by immediately resolving
            if (angular.isDefined(_identity)) {
              deferred.resolve(_identity);

              return deferred.promise;
            }

            // otherwise, retrieve the identity data from the server, update the identity object, and then resolve.
            // $http.get('/svc/account/identity', {
            //     ignoreErrors: true
            //   })
            //   .success(function(data) {
            //     _identity = data;
            //     _authenticated = true;
            //     deferred.resolve(_identity);
            //   })
            //   .error(function() {
            //     _identity = null;
            //     _authenticated = false;
            //     deferred.resolve(_identity);
            //   });

            // for the sake of the demo, we'll attempt to read the identity from localStorage. the example above might be a way if you use cookies or need to retrieve the latest identity from an api
            // i put it in a timeout to illustrate deferred resolution
            var self = this;
            $timeout(function() {
              _identity = angular.fromJson($cookies.getObject("meishi.identity"));
              self.authenticate(_identity);
              deferred.resolve(_identity);
            }, 1000);

            return deferred.promise;
          }
        };
      }
    ])
    .factory('authorization', ['$rootScope', '$state', 'principal',
      function($rootScope, $state, principal) {
        return {
          authorize: function() {
            return principal.identity()
              .then(function() {
                var isAuthenticated = principal.isAuthenticated();

                if ($rootScope.toState.data.roles && $rootScope.toState.data.roles.length > 0 && !principal.isInAnyRole($rootScope.toState.data.roles)) {
                  if (isAuthenticated) $state.go('accessdenied'); // user is signed in but not authorized for desired state
                  else {
                    // user is not authenticated. stow the state they wanted before you
                    // send them to the signin state, so you can return them when you're done
                    $rootScope.returnToState = $rootScope.toState;
                    $rootScope.returnToStateParams = $rootScope.toStateParams;

                    // now, send them to the signin state so they can log in
                    $state.go('signin');
                  }
                }
              });
          }
        };
      }
    ]);

});
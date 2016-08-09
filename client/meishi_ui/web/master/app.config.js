define(function() {
  //Cache

  var loadController = function(controllerName) {
    return ["$q", function($q) {
      var deferred = $q.defer();
      require([controllerName], function() {
        deferred.resolve();
      });
      return deferred.promise;
    }];
  };

  angular.module('meishi')
    .config(['$controllerProvider', '$provide',
      function(controllerProvider, provide) {
        app_cached_providers.$controllerProvider = controllerProvider;
        app_cached_providers.$provide = provide;
      }
    ])
    .config(function($authProvider) {
      $authProvider.configure({
        apiUrl: 'http://api.localhost:3000'
      });
    })
    .config(['$stateProvider', '$urlRouterProvider',
      function($stateProvider, $urlRouterProvider) {

        $urlRouterProvider
          .otherwise("/signin");

        $stateProvider.state('site', {
          views: {
            "content": {
              templateUrl: "master/header.html",
              controller: 'appController'
            }
          },
          abstract: true,
          resolve: {
            authorize: ['authorization',
              function(authorization) {
                return authorization.authorize();
              }
            ]
          }
        });

        //Authenticated state
        $stateProvider
          .state("dashboard", {
            parent: 'site',
            url: '/dashboard',
            data: {
              roles: ['User']
            },
            templateUrl: "dashboard/dashboard.html",
            controller: 'dashboardCtrl',
            resolve: {
              loadDashboardCtrl: loadController('dashboardCtrl'),
              loadDashboardFactory: loadController('dashboardFactory')
            }
          })
          .state("filter", {
            parent: 'site',
            url: '/filter/:option',
            data: {
              roles: ['User']
            },
            templateUrl: "filter/filter.html",
            controller: 'filterCtrl',
            resolve: {
              loadFilterCtrl: loadController('filterCtrl'),
              loadFilterFactory: loadController('filterFactory')
            }
          })
          .state("detail", {
            parent: 'site',
            url: '/bizcards/:index',
            data: {
              roles: ['User']
            },
            templateUrl: "detail/detail.html",
            controller: 'detailCtrl',
            resolve: {
              loadDetailCtrl: loadController('detailCtrl'),
              loadDetailFactory: loadController('detailFactory')
            }
          })
          .state("update", {
            parent: 'site',
            url: '/update/:id',
            data: {
              roles: ['User']
            },
            templateUrl: "update/update.html",
            controller: 'updateCtrl',
            resolve: {
              loadupdateCtrl: loadController('updateCtrl')
            }
          });

          //Anonimous State
        $stateProvider
          .state("signin", {
            url: "/signin",
            data: {
              roles: []
            },
            views: {
              "content": {
                templateUrl: "login/login.html",
                controller: "loginCtrl",
              }
            },
            resolve: {
              loadLoginCtrl: loadController("loginCtrl")
            }
          });

      }
    ])
    .run(['$rootScope', '$state', '$stateParams', 'authorization', 'principal',
      function($rootScope, $state, $stateParams, authorization, principal) {
        $rootScope.$on('$stateChangeStart', function(event, toState, toStateParams) {

          $rootScope.toState = toState;
          $rootScope.toStateParams = toStateParams;

          if (principal.isIdentityResolved()) authorization.authorize();
        });
      }
    ]);


});
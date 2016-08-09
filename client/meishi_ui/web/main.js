require.config({

  paths: {
    //Angular path
    'angular': '../lib/bower_components/angular/angular',
    //ng-token-auth <- rails
    'angular-cookie': '../lib/bower_components/angular-cookie/angular-cookie',
    'angular-ui-route': '../lib/bower_components/angular-ui-router/release/angular-ui-router',
    'ng-token-auth': '../lib/bower_components/ng-token-auth/dist/ng-token-auth',
    'jquery': '../lib/bower_components/jquery/dist/jquery',
    'bootstrap': '../lib/bower_components/bootstrap/dist/js/bootstrap',
    'bootstrap-select': '../lib/bower_components/bootstrap-select/dist/js/bootstrap-select',
    'interact': '../lib/bower_components/interact/dist/interact',

    //App deps
    'app-module': 'master/app.module',
    'app-config': 'master/app.config',
    'app-controller': 'master/app.controller',
    'app-factory': 'master/app.factory',

    //Login
    'loginCtrl': 'login/login.controller',

    //Dashboard
    'dashboardCtrl': 'dashboard/dashboard.controller',
    'dashboardFactory': 'dashboard/dashboard.factory',

    //filter
    'filterCtrl': 'filter/filter.controller',
    'filterFactory': 'filter/filter.factory',

    //detail
    'detailCtrl': 'detail/detail.controller',
    'detailFactory': 'detail/detail.factory',

    //update
    'updateCtrl': 'update/update.controller',
    'updateFactory': 'update/update.factory',
  },

  shim: {

    'app-module': {
      deps: [
        'angular', 'angular-cookie', 'ng-token-auth', 'angular-ui-route', 'bootstrap'
      ]
    },

    'bootstrap': {
      deps: ['jquery']
    },
    // 'bootstrap-select':
    'app-controller': {
      deps: ['angular', 'app-module']
    },
    'app-config': {
      deps: ['angular', 'app-module']
    },
    'app-factory': {
      deps: ['angular', 'app-module']
    },
    'angular-cookie': {
      deps: ['angular']
    },
    'angular-ui-route': {
      deps: ['angular']
    },
    'ng-token-auth': {
      deps: ['angular', 'angular-cookie']
    },
    'updateCtrl': {
      deps: ['updateFactory']
    }

  }

});


var app_cached_providers = {};

require(['app-module', 'app-controller', 'app-factory', 'app-config'], function() {
  angular.bootstrap(document, ['meishi']);
});
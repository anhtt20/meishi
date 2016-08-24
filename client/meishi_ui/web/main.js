require.config({

  paths: {
    //Angular path
    'angular': '../lib/bower_components/angular/angular',

    //<- rails
    'angular-cookies': '../lib/bower_components/angular-cookies/angular-cookies',
    'angular-ui-route': '../lib/bower_components/angular-ui-router/release/angular-ui-router',

    //Angular-materia required
    'angular-animate': '../lib/bower_components/angular-animate/angular-animate',
    'angular-aria': '../lib/bower_components/angular-aria/angular-aria',
    'angular-message': '../lib/bower_components/angular-messages/angular-messages',
    'angular-material': '../lib/bower_components/angular-material/angular-material',

    //htmltocanvas
    'dom-to-image': '../lib/bower_components/dom-to-image/src/dom-to-image',

    //Interact Lib
    'interact': '../lib/bower_components/interact/interact',

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
        'angular', 'angular-cookies', 'angular-ui-route', 'angular-material'
      ]
    },

    'angular-material': {
      deps: [
        'angular', 'angular-animate', 'angular-aria', 'angular-message'
      ]
    },
    'angular-aria': {
      deps: ['angular']
    },
    'angular-animate': {
      deps: ['angular']
    },
    'angular-message': {
      deps: ['angular']
    },
    'angular-datagrid': {
      deps: ['angular']
    },
    'angular-paging': {
      deps: ['angular']
    },

    'app-controller': {
      deps: ['angular', 'app-module']
    },
    'app-config': {
      deps: ['angular', 'app-module']
    },
    'app-factory': {
      deps: ['angular', 'app-module']
    },
    'angular-cookies': {
      deps: ['angular']
    },
    'angular-ui-route': {
      deps: ['angular']
    },
    'ng-token-auth': {
      deps: ['angular', 'angular-cookie']
    },
    'updateCtrl': {
      deps: ['updateFactory' , 'dom-to-image']
    }

  }

});


var app_cached_providers = {};
var api_root = 'http://api.localhost:3000/v1/';
var api_static = 'http://api.localhost:3000/';

require(['app-module', 'app-controller', 'app-factory', 'app-config'], function() {
  angular.bootstrap(document, ['meishi']);
});
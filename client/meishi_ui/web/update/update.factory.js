define(function() {

  app_cached_providers
    .$provide
    .factory('updateUtil', ['$q', '$http', '$filter',
      function($q, $http, $filter) {
        var loading = true;

        return {
          add: function(meishi) {
            console.log(meishi);
            var bcs = angular.fromJson(localStorage.getItem("demo.bizcards"));
            _identity = angular.fromJson(localStorage.getItem("demo.identity"));
            meishi.id = bcs.lenght;
            meishi.createBy = _identity.name;
            meishi.owner = false;
            bcs.push(meishi);
            localStorage.setItem("demo.bizcards", angular.toJson(bcs));

            return true;
          }
        };
      }
    ]);

});
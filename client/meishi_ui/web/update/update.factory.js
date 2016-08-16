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
          },
          all: function loadAll() {
            var allStates = 'Alabama, Alaska, Arizona, Arkansas, California, Colorado, Connecticut, Delaware,\
              Florida, Georgia, Hawaii, Idaho, Illinois, Indiana, Iowa, Kansas, Kentucky, Louisiana,\
              Maine, Maryland, Massachusetts, Michigan, Minnesota, Mississippi, Missouri, Montana,\
              Nebraska, Nevada, New Hampshire, New Jersey, New Mexico, New York, North Carolina,\
              North Dakota, Ohio, Oklahoma, Oregon, Pennsylvania, Rhode Island, South Carolina,\
              South Dakota, Tennessee, Texas, Utah, Vermont, Virginia, Washington, West Virginia,\
              Wisconsin, Wyoming';
            return allStates.split(/, +/g).map(function(state) {
              return {
                value: state.toLowerCase(),
                display: state
              };
            });
          }
        };
      }
    ]);
});
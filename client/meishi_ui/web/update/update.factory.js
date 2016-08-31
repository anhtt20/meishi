define(function() {

  app_cached_providers
    .$provide
    .factory('updateUtil', ['$q', '$http', '$filter', 'domtoimage', '$mdDialog', '$state',
      function($q, $http, $filter, domtoimage, $mdDialog, $state) {

        function pushError(data) {
          if (data.status == '401') {
            $state.go('signin');
          } else {
            var confirm = $mdDialog.confirm()
              .title('通知')
              .textContent(data.message)
              .ok('完了');
            $mdDialog.show(confirm)
              .then(function() {
                  $state.go('filter', {
                    option: 'all'
                  });
                },
                function() {
                  $state.go('filter', {
                    option: 'all'
                  });
                });
          }
        };

        return {
          add: function(meishi, next) {
            generateMeishi('meishi-omt').then(function(e) {
              meishi.i_omt = e;
              $http({
                  method: 'POST',
                  url: api_root + 'business_cards',
                  data: angular.toJson(meishi)
                }).success(function(data, status, headers, config) {
                  //console.debug(data);
                  next(data);
                })
                .error(function(data, status, headers, config) {
                  pushError(data);
                });
            });
          },
          update: function(meishi, next) {
            generateMeishi('meishi-omt').then(function(e) {
              meishi.i_omt = e;
              $http({
                  method: 'PUT',
                  url: api_root + 'business_cards/' + meishi.id,
                  data: angular.toJson(meishi)
                }).success(function(data, status, headers, config) {
                  //console.debug(data);
                  next(data);
                })
                .error(function(response) {
                  pushError(data);
                });
            });
          },
          companies: function(keyword, next) {
            $http({
                method: 'GET',
                url: api_root + 'companies?keyword=' + encodeURIComponent(keyword)
              }).success(function(data, status, headers, config) {
                //console.debug(data);
                if (data) next(data);
              })
              .error(function(data, status, headers, config) {
                console.log(data);
              });
          },
          departments: function(keyword, next) {
            $http({
                method: 'GET',
                url: api_root + 'departments?keyword=' + encodeURIComponent(keyword)
              }).success(function(data, status, headers, config) {
                //console.debug(data);
                if (data) next(data);
              })
              .error(function(data, status, headers, config) {
                console.log(data);
              });
          },
          loadDrag: settingDrag(),
          getItem: function(id, next) {
            $http.get(api_root + 'business_cards/' + id)
              .success(function(data, status, headers, config) {
                //console.debug(data);
                if (data) next(data);
              })
              .error(function(data, status, headers, config) {
                pushError(data);
              });
          }
        };

        function generateMeishi(element) {
          return domtoimage.toPng(document.getElementById(element))
            .then(function(dataUrl) {
              return dataUrl;
            })
            .catch(function(error) {
              console.error('oops, something went wrong!', error);
              return '';
            });
        }

        function settingDrag() {
          require(['interact'], function(interact) {

            interact('.draggable')
              .draggable({
                inertia: true,
                restrict: {
                  restriction: document.getElementById('grid-zone'),
                  elementRect: {
                    top: 0,
                    left: 0,
                    bottom: 0,
                    right: 0
                  },
                  endOnly: true
                }
              })
              .on('dragmove', function(event) {
                var target = event.target,
                  // keep the dragged position in the data-x/data-y attributes
                  x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx,
                  y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy;

                // translate the element
                target.style.webkitTransform =
                  target.style.transform =
                  'translate(' + x + 'px, ' + y + 'px)';

                // update the posiion attributes
                target.setAttribute('data-x', x);
                target.setAttribute('data-y', y);
              });
          });
        };
      }
    ]);
});
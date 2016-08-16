define(function() {
  app_cached_providers
    .$controllerProvider
    .register('updateCtrl', ['$rootScope', '$scope', '$state', 'updateUtil', '$q', '$timeout', '$mdSidenav', 'domtoimage',
      function($rootScope, $scope, $state, updateUtil, $q, $timeout, $mdSidenav, domtoimage) {

        //Main Function
        $scope.update = function(meishi) {
          
          // if (updateUtil.add(meishi)) {
          //   $state.go('dashboard');
          // }
          domtoimage.toPng(document.getElementById('meishi-omt'))
            .then(function(dataUrl) {
              $scope.meishi.i_omt = dataUrl;
              console.log(meishi);
            })
            .catch(function(error) {
              console.error('oops, something went wrong!', error);
            });
        };

        //Properties
        $scope.states = updateUtil.all();
        $scope.meishi = {
          name: '田中',
          furigana: 'タナカ',
          email: 'tanaka@gmail.com',
          tel: '070-1245-3456',
          c_name: 'IDOM',
          c_address: '東京都千代田区丸の内２丁目７−３',
          c_post_code: '100-0005',

          tags: []
        };
        $scope.config = {
          name: true,
          furigana: false,
          email: true,
          tel: true,
          c_name: true,
          c_address: true,
          c_post_code: true
        }

        $scope.editElement = null;
        $scope.isDraw = function() {
          return $scope.editElement ? true : false;
        };
        $scope.$watch('editElement.size', function(val) {
          if ($scope.editElement) {
            $scope.editElement.ele.style.fontSize = val;
          }
        });
        $scope.$watch('editElement.B', function(val) {
          if ($scope.editElement) {
            $scope.editElement.ele.style.fontWeight = val ? 'bold' : 'normal';
          }
        });
        $scope.$watch('editElement.I', function(val) {
          if ($scope.editElement) {
            $scope.editElement.ele.style.fontStyle = val ? 'italic' : 'normal';
          }
        });

        //Open right slide
        $scope.toggleSlide = function($event) {
          if ($event) {
            $scope.editElement = {
              ele: $event.target,
              size: parseFloat(window.getComputedStyle($event.target, null).getPropertyValue('font-size')),
              B: window.getComputedStyle($event.target, null).getPropertyValue('font-weight') === 'bold',
              I: window.getComputedStyle($event.target, null).getPropertyValue('font-style') === 'italic'
            }
          }
          $mdSidenav('slide')
            .toggle();
        }
        $scope.isOpenSlide = function() {
          return $mdSidenav('slide').isOpen();
        };
        $scope.$watch('isOpenSlide()', function(val) {
          if (!val) $scope.editElement = null;
        });

        //Autocomplete
        $scope.querySearch = function(query) {
          console.log(query);
          var results = query ? $scope.states.filter(createFilterFor(query)) : $scope.states;

          console.log(results);
          var deferred = $q.defer();
          $timeout(function() {
            deferred.resolve(results);
          }, Math.random() * 1000, false);
          return deferred.promise;
        };

        function createFilterFor(query) {
          var lowercaseQuery = angular.lowercase(query);
          return function filterFn(state) {
            return (state.value.indexOf(lowercaseQuery) === 0);
          };
        }

        settingDrag();

        function settingDrag(){
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
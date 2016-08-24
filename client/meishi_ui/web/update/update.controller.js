define(function() {
  app_cached_providers
    .$controllerProvider
    .register('updateCtrl', ['$rootScope', '$scope', '$state', 'updateUtil', '$q', '$timeout', '$mdSidenav', '$mdDialog', '$http', '$stateParams',
      function($rootScope, $scope, $state, updateUtil, $q, $timeout, $mdSidenav, $mdDialog, $http, $stateParams) {
        var id = $stateParams.id

        //Title
        $rootScope.Title = "ホアンホアン｜追加"
          //Properties
        $scope.meishi;

        if (id != 'new') {
          updateUtil.getItem(id, function(data) {
            $scope.meishi = {
              id: data.business_card_id,
              name: data.name,
              furigana: data.furigana,
              email: data.email,
              tel: data.tel,
              recieve_date: new Date(data.recieve_date),
              c_name: data.company ? data.company.name : null,
              c_address: data.company ? data.company.address : null,
              c_email: data.company ? data.company.email : null,
              c_tel: data.company ? data.company.tel : null,
              c_fax: data.company ? data.company.fax : null,
              c_url: data.company ? data.company.url : null,
              c_post_code: data.company ? data.company.post_code : null,
              d_name: data.department ? data.department.name : null
            };

            $scope.isUpdate = true;
          });
        }

        //Main Function
        $scope.update = function(meishi) {
          if ($scope.isUpdate) {
            updateUtil.update(meishi, function(data) {
              $mdDialog.hide();
              $state.go('filter', {
                option: 'me'
              });
            });
          } else {
            updateUtil.add(meishi, function(data) {
              $mdDialog.hide();
              $state.go('detail', {
                index: data.business_card_id
              });
            });
          }
        };

        $scope.showConfirm = function(ev) {
          var confirm = $mdDialog.confirm()
            .title('情報確認')
            .textContent('入力した情報は確認してください。')
            .targetEvent(ev)
            .ok('登録')
            .cancel('キャンセル');
          $mdDialog.show(confirm)
            .then(function() {
              if ($scope.isUpdate) {
                updateUtil.update($scope.meishi, function(data) {
                  $mdDialog.hide();
                  $state.go('detail', {
                    index: data.business_card_id
                  });
                });
              } else {
                updateUtil.add($scope.meishi, function(data) {
                  $mdDialog.hide();
                  $state.go('detail', {
                    index: data.business_card_id
                  });
                });
              }
            });
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
        $scope.departmentsQuerySearch = function(query) {
          var deferred = $q.defer();
          updateUtil.departments(query, function(data){
            deferred.resolve(data);
          });
          return deferred.promise;
        };

        $scope.companiesQuerySearch = function(query) {
          var deferred = $q.defer();
          updateUtil.companies(query, function(data){
            deferred.resolve(data);
          });
          return deferred.promise;
        };

        function createFilterFor(query) {
          var lowercaseQuery = angular.lowercase(query);
          return function filterFn(state) {
            return (state.value.indexOf(lowercaseQuery) === 0);
          };
        }
      }
    ]);
});
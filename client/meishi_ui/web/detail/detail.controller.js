define(function() {

  app_cached_providers
    .$controllerProvider
    .register('detailCtrl', ['$rootScope', '$stateParams', '$scope', '$state', 'bizcard', '$mdDialog',
      function($rootScope, $stateParams, $scope, $state, bizcard, $mdDialog) {
        //Title
        $rootScope.Title = "ホアンホアン｜詳細";

        $scope.meishi;

        bizcard.getItem($stateParams.index, function(data) {
          console.debug(data);
          $scope.meishi = data;
          if ($scope.meishi.recieve_date)
            $scope.meishi.recieve_date = new Date($scope.meishi.recieve_date);
          if (data.file_locations && data.file_locations.length > 0)
            $scope.meishi.i_omt = 'http://api.localhost:3000/' + data.file_locations[0].domain + data.file_locations[0].path;
        });

        $scope.showConfirm = function(ev, id) {
          var confirm = $mdDialog.confirm()
            .title('削除確認')
            .textContent('この名刺情報を削除しますか。')
            .targetEvent(ev)
            .ok('完了')
            .cancel('キャンセル');
          $mdDialog.show(confirm)
            .then(function() {
              bizcard.destoyItem(id, function() {
                $state.go('filter', {
                  option: 'me'
                });
              });
            });
        };
      }
    ]);

});
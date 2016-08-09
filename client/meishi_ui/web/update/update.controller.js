define(function() {
  app_cached_providers
    .$controllerProvider
    .register('updateCtrl', ['$rootScope', '$scope', '$state', 'updateUtil',
      function($rootScope, $scope, $state, updateUtil) {

        $scope.update = function(meishi) {
          console.log(meishi);
          if (updateUtil.add(meishi)) {
            $state.go('dashboard');
          }
        };

        // var element = document.getElementById('grid-snap'),
        //   x = 0,
        //   y = 0;
        // interact(element)
        //   .draggable({
        //     snap: {
        //       targets: [
        //         interact.updateSnapGrid({
        //           x: 30,
        //           y: 30
        //         })
        //       ],
        //       range: Infinity,
        //       relativePoints: [{
        //         x: 0,
        //         y: 0
        //       }]
        //     },
        //     inertia: true,
        //     restrict: {
        //       restriction: element.parentNode,
        //       elementRect: {
        //         top: 0,
        //         left: 0,
        //         bottom: 1,
        //         right: 1
        //       },
        //       endOnly: true
        //     }
        //   })
        //   .on('dragmove', function(event) {
        //     x += event.dx;
        //     y += event.dy;
        //     event.target.style.webkitTransform =
        //       event.target.style.transform =
        //       'translate(' + x + 'px, ' + y + 'px)';
        //   });
      }
    ]);
});
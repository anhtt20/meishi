define(function() {

  app_cached_providers
    .$provide
    .factory('filter', ['$q', '$http', '$filter',
      function($q, $http, $filter) {
        var loading = true;

        return {
          fetchAll: function(option) {
            var bcs = angular.fromJson(localStorage.getItem("demo.bizcards"));
            if (!bcs) {
              bcs = [{
                id: 1,
                name: 'Hoang',
                furigana: 'ホアン',
                company: 'IDOM',
                deparment: '開発部',
                owner: true,
                createBy: 'hoang'
              }, {
                id: 2,
                name: '大輔',
                furigana: 'フリガナ',
                company: '秋川牧園',
                deparment: '総務部',
                owner: false,
                createBy: 'hoang'
              }, {
                id: 3,
                name: '誠',
                furigana: 'フリガナ',
                company: 'IDOM',
                deparment: '人事部',
                owner: false,
                createBy: 'hoang'
              }, {
                id: 4,
                name: '直樹',
                furigana: 'フリガナ',
                company: '極洋',
                deparment: '営業部',
                owner: false,
                createBy: 'hoang'
              }, {
                id: 5,
                name: '哲也',
                furigana: 'フリガナ',
                company: '小岩井農場',
                deparment: '開発部',
                owner: false,
                createBy: 'hoang'
              }, {
                id: 6,
                name: '久美子',
                furigana: 'フリガナ',
                company: '小林種苗',
                deparment: '開発部',
                owner: false,
                createBy: 'demo'  
              }];

              localStorage.setItem("demo.bizcards", angular.toJson(bcs));

            };
            if (option == 'self') {
              _identity = angular.fromJson(localStorage.getItem("demo.identity"));
              bcs = $filter('filter')(bcs, {
                createBy: _identity.name
              });
            }

            return bcs;
          },

        };
      }
    ]);

});
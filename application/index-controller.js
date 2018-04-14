app.controller('indexController',function ($scope, $http, $templateCache, $window) {
    $scope.email = null;
    $scope.password = null;
    $scope.loginDetails = {};
    $scope.login = function () {
        console.log($scope.email + "---" + $scope.password);
        $scope.loginDetails = {email: $scope.email, password: $scope.password};
        $scope.data = $scope.loginDetails;
        console.log($scope.data);
        $http({
            url: "login.php",
            method: "POST",
            data: $.param({'data': $scope.data}),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            cache: $templateCache
        }).then(function (value) {
            var responseData=value.data;
            var data=JSON.parse(responseData['data']);
            var homeLink=data['homeLink'];
            $window.location.href=homeLink;
        }, function (reason) {
            console.log(reason);
        });
    };
});
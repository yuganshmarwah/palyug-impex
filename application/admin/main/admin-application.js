var app=angular.module("AdminApplication", ["ngRoute"]);

app.config(function($routeProvider){
    $routeProvider
            .when('/',{templateUrl:'dashboard.html'})
            .when('/charts',{templateUrl:'charts.html',controller:'editPostController'})
            .when('/newPost',{templateUrl:'newPost.html',controller:'newPostController'})
            .when('/deletePost',{templateUrl:'deletePost.html',controller:'deletePostController'})
            .when('/download',{templateUrl:'download.html',controller:'downloadController'});
});
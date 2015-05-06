var app = angular.module('fashion', ['ui.bootstrap']);

app.factory('fashionHomePageService', function ($http) {
	return {		

		getChannelPictures: function (category, count, skip) {
			return $http.get('/api/latestnews/channel?c=' + category + '&l=' + count + '&skip=' + skip).then(function (result) {
			return result.data.articles;
			});
		},
		
		getChannelVideos: function (category, count, skip) {
			return $http.get('/api/latestvideos/channel?c=' + category + '&l=' + count + '&skip=' + skip).then(function (result) {
			return result.data.articles;
			});
		},
		
		getlatestgallery: function (category, count, skip) {
			return $http.get('/api/gallery/channel?c=' + category + '&l=' + count + '&skip=' + skip).then(function (result) {
			return result.data.articles;
			});
		},
		getChannelBeautyPictures: function (category, count, skip) {
			return $http.get('/api/latestbeautynews/channel?c=' + category + '&l=' + count + '&skip=' + skip).then(function (result) {
			return result.data.articles;
			});
		}		
	};
});
app.controller('FashionHome', function ($scope, fashionHomePageService) {
  //the clean and simple way
  $scope.latestNews = fashionHomePageService.getChannelPictures('fashion_view',4,0);
  $scope.latestNews1 = fashionHomePageService.getChannelPictures('fashion_view',8,0);
  $scope.latestNews2 = fashionHomePageService.getChannelPictures('fashion_view',5,0);

  $scope.latestVideos = fashionHomePageService.getChannelVideos('by_id_title_desc_thumb_date',6,0);
  $scope.latestVideos1 = fashionHomePageService.getChannelVideos('by_id_title_desc_thumb_date',9,0);
  $scope.popularVideos = fashionHomePageService.getChannelVideos('by_id_title_desc_thumb_date',6,6);
  	
  $scope.gallery = fashionHomePageService.getlatestgallery('image_gallery_view',8,0);
  $scope.gallery1 = fashionHomePageService.getlatestgallery('image_gallery_view',4,0);
  $scope.gallery2 = fashionHomePageService.getlatestgallery('image_gallery_view',12,0);

  $scope.beautyNews = fashionHomePageService.getChannelBeautyPictures('beauty_view',9,0);
  $scope.currentYear = (new Date).getFullYear();

  // start of code for generating cb,pagetit,pageurl
 	var video = "http://video.contentapi.ws/"+$('#video_val').val();
 	var vastURI = 'http://vast.optimatic.com/vast/getVast.aspx?id=ezyf451hion&zone=vpaidtag&pageURL=[INSERT_PAGE_URL]&pageTitle=[INSERT_PAGE_TITLE]&cb=[CACHE_BUSTER]';
	function updateURL(vastURI){
	// Generate a huge random number
	var ord=Math.random(), protocol, host, port, path, pageUrl, updatedURI;
	var parsedFragments = parseUri(vastURI);
	ord = ord * 10000000000000000000;
	// Protocol of VAST URI
	protocol = parsedFragments.protocol;
	// VAST URI hostname
	host = parsedFragments.host;
	// VAST URI Path
	path = parsedFragments.path;
	//VAST Page Url
	pageUrl = parsedFragments.queryKey.pageUrl
	var fragmentString ='';
	//Updated URI
	for(var key in parsedFragments.queryKey){//console.log("abhii");console.log();
		// For Cache buster add a large random number
		if(key == 'cb'){
			fragmentString = fragmentString + key + '=' + ord + '&';	
		}
		// for referring Page URL, get the current document URL and encode the URI
		else if(key == 'pageURL'){
			var currentUrl = document.URL;
			fragmentString = fragmentString + key + '=' + currentUrl + '&';	
		}else if(key == 'pageTitle'){
			var page_title=document.title;
			fragmentString = fragmentString + key + '=' + page_title + '&';	
		}
		else{
			fragmentString = fragmentString + key + '=' + parsedFragments.queryKey[key] + '&';
		}
		
	}

	updatedURI = protocol + '://' + host + path + '?' + fragmentString ;
	
	// Remove the trailing & and return the updated URL
	return updatedURI.slice(0,-1);
	}

	// Parse URI to get qeury string like cb for cache buster and pageurl
	function parseUri (str) {
		var	o   = parseUri.options,
			m   = o.parser[o.strictMode ? "strict" : "loose"].exec(str),
			uri = {},
			i   = 14;

		while (i--) uri[o.key[i]] = m[i] || "";

		uri[o.q.name] = {};
		uri[o.key[12]].replace(o.q.parser, function ($0, $1, $2) {
			if ($1) uri[o.q.name][$1] = $2;
		});

		return uri;
	};

	parseUri.options = {
		strictMode: false,
		key: ["source","protocol","authority","userInfo","user","password","host","port","relative","path","directory","file","query","anchor"],
		q:   {
			name:   "queryKey",
			parser: /(?:^|&)([^&=]*)=?([^&]*)/g
		},
		parser: {
			strict: /^(?:([^:\/?#]+):)?(?:\/\/((?:(([^:@]*)(?::([^:@]*))?)?@)?([^:\/?#]*)(?::(\d*))?))?((((?:[^?#\/]*\/)*)([^?#]*))(?:\?([^#]*))?(?:#(.*))?)/,
			loose:  /^(?:(?![^:@]+:[^:@\/]*@)([^:\/?#.]+):)?(?:\/\/)?((?:(([^:@]*)(?::([^:@]*))?)?@)?([^:\/?#]*)(?::(\d*))?)(((\/(?:[^?#](?![^?#\/]*\.[^?#\/.]+(?:[?#]|$)))*\/?)?([^?#\/]*))(?:\?([^#]*))?(?:#(.*))?)/
		}
	};
	// end of code for generating cb,pagetit,pageurl
	$scope.loadVideo = function(){
		$(document).ready(function() {
			jwplayer('trailor').setup({
                  "flashplayer": "http://player.longtailvideo.com/player.swf",
                  "playlist": [
                    {
                      "file": video
                    }
                  ],
                  "width": '100%',
                  "height": 400,
                  stretching: "exactfit",
                  skin: "http://content.longtailvideo.com/skins/glow/glow.zip",
                  autostart: true,
                  "autoPlay": true,
                  "controlbar": {
                    "position": "bottom"
                  },
                  "plugins": {
                  	 "autoPlay": true,
                    "ova-jw": {
                    	 "ads": {
                        "schedule": [
                          {
                            "position": "pre-roll",
                            "tag": updateURL(vastURI)
                            //"tag": "http://vast.optimatic.com/vast/getVast.aspx?id=w984i078l984&zone=vpaidtag&pageURL=[INSERT_PAGE_URL]&pageTitle=[INSERT_PAGE_TITLE]&cb=[CACHE_BUSTER]"
                          }
                        ]
                      },
                      "debug": {
                        "levels": "none"
                      }
                    }
                  }
                });
		})
	
	};

});
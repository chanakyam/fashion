-module(fashion_util).
-include("includes.hrl").

-export([newsdb_url/0,
		 videosdb_url/0,		 		  
		 thumb_title_count/3,
		 % thumb_title_video_count/3,
		 news_item_url/1,
		 news_top_text_news_by_category_with_limit_and_skip/3,
		 beauty_news_by_category_with_limit_and_skip/3,
		 % videos_news_top_text_news_by_category_with_limit_and_skip/3,
		 news_count/1,
		 beauty_count/1,
		 % videos_count/1,
		 gallery_thumb_title_count/3,
		 photo_gallery_list/1,
		 play_video_item_url/1,
		 get_beauty_data/3

		]).

newsdb_url() ->
	string:concat(?COUCHDB_URL, ?COUCHDB_TEXT_GRAPHICS)
.
videosdb_url() ->
	string:concat(?COUCHDB_URL, ?COUCHDB_TEXT_GRAPHICS_VIDEOS)
.
get_beauty_data(Category, Limit, Skip) ->
	%http://couchdb.speakglobally.net/wildridge_latest/_design/slideshow/_view/us_nba?descending=true&limit=2
	Url1 = string:concat(?MODULE:newsdb_url(),"_design/beauty_design/_view/"),
	Url2 = string:concat(Url1, Category),
	Url3 = string:concat(Url2, "?descending=true&limit="),
	Url4 = string:concat(Url3, Limit),
	Url5 = string:concat(Url4, "&skip="),
	io:format("url fashion_util ~p ~n ",[Url5]),
	string:concat(Url5, Skip)
.

thumb_title_count(Category, Limit, Skip) ->
	%http://couchdb.speakglobally.net/wildridge_latest/_design/slideshow/_view/us_nba?descending=true&limit=2
	Url1 = string:concat(?MODULE:newsdb_url(),"_design/fashion_design/_view/"),
	Url2 = string:concat(Url1, Category),
	Url3 = string:concat(Url2, "?descending=true&limit="),
	Url4 = string:concat(Url3, Limit),
	Url5 = string:concat(Url4, "&skip="),
	io:format("url fashion_util ~p ~n ",[Url5]),
	string:concat(Url5, Skip)
.
% thumb_title_video_count(Category, Limit, Skip) ->
% 	%http://couchdb.speakglobally.net/wildridge_latest/_design/slideshow/_view/us_nba?descending=true&limit=2
% 	Url1 = string:concat(?MODULE:videosdb_url(),"_design/video_movies/_view/"),
% 	Url2 = string:concat(Url1, Category),
% 	Url3 = string:concat(Url2, "?descending=true&limit="),
% 	Url4 = string:concat(Url3, Limit),
% 	Url5 = string:concat(Url4, "&skip="),
% 	io:format("url fashion_util ~p ~n ",[Url5]),
% 	string:concat(Url5, Skip)
% .
news_item_url(Id) ->
	string:concat(?MODULE:newsdb_url(),Id)
.
news_top_text_news_by_category_with_limit_and_skip(Category, Limit, Skip) ->
	%% http://localhost:5984/reconlive/_design/news_by_category/_view/us_news?descending=true&limit=10
	Url  = string:concat(?MODULE:newsdb_url(), "_design/fashion_design/_view/"), 
	Url1 = string:concat(Url,Category ),	
	Url3 = string:concat(Url1, "?descending=true&limit="),
	Url4 = string:concat(Url3, Limit),
	Url5 = string:concat(Url4, "&skip="),
	io:format("url fashion_util ~p ~n ",[Url5]),
	string:concat(Url5, Skip)	
.

beauty_news_by_category_with_limit_and_skip(Category, Limit, Skip) ->
	%% http://localhost:5984/reconlive/_design/news_by_category/_view/us_news?descending=true&limit=10
	Url  = string:concat(?MODULE:newsdb_url(), "_design/beauty_design/_view/"), 
	Url1 = string:concat(Url,Category ),	
	Url3 = string:concat(Url1, "?descending=true&limit="),
	Url4 = string:concat(Url3, Limit),
	Url5 = string:concat(Url4, "&skip="),
	io:format("url fashion_util ~p ~n ",[Url5]),
	string:concat(Url5, Skip)	
.



% videos_news_top_text_news_by_category_with_limit_and_skip(Category, Limit, Skip) ->
% 	%% http://localhost:5984/reconlive/_design/news_by_category/_view/us_news?descending=true&limit=10
% 	Url  = string:concat(?MODULE:videosdb_url(), "_design/video_movies/_view/"), 
% 	Url1 = string:concat(Url,Category ),	
% 	Url3 = string:concat(Url1, "?descending=true&limit="),
% 	Url4 = string:concat(Url3, Limit),
% 	Url5 = string:concat(Url4, "&skip="),
% 	string:concat(Url5, Skip)	
% .
news_count(Category) ->
	%% http://localhost:5984/reconlive/_design/get_count/_view/<category>
	Url1 = string:concat(?MODULE:newsdb_url(), "_design/fashion_design/_view/"),
	Url2 = string:concat(Url1, Category),	
	string:concat(Url2, "?descending=true&limit=1")
.
beauty_count(Category) ->
	%% http://localhost:5984/reconlive/_design/get_count/_view/<category>
	Url1 = string:concat(?MODULE:newsdb_url(), "_design/beauty_design/_view/"),
	Url2 = string:concat(Url1, Category),	
	io:format("url fashion_util~p ~n ",[Url2]),
	string:concat(Url2, "?descending=true&limit=1")
.
% videos_count(Category) ->
% 	%% http://localhost:5984/reconlive/_design/get_count/_view/<category>
% 	Url1 = string:concat(?MODULE:videosdb_url(), "_design/video_movies/_view/"),
% 	Url2 = string:concat(Url1, Category),	
% 	io:format("url fashion_util~p ~n ",[Url2]),
% 	string:concat(Url2, "?descending=true&limit=1")
% .
play_video_item_url(Id) ->
	string:concat(?MODULE:videosdb_url(),Id)
.
gallery_thumb_title_count(Category, Limit, Skip) ->
	%http://couchdb.speakglobally.net/wildridge_latest/_design/slideshow/_view/us_nba?descending=true&limit=2
	Url1 = string:concat(?MODULE:newsdb_url(),"_design/image_gallery_design/_view/"),
	Url2 = string:concat(Url1, Category),
	Url3 = string:concat(Url2, "?descending=true&limit="),
	Url4 = string:concat(Url3, Limit),
	Url5 = string:concat(Url4, "&skip="),
	io:format("url fashion_util ~p ~n ",[Url5]),
	string:concat(Url5, Skip)
.
photo_gallery_list(Category) ->
 	%% http://localhost:5984/reconlive/_design/get_count/_view/<category>
 	Url1 = string:concat(?MODULE:newsdb_url(), "_design/image_gallery_design/_view/"),
 	Url2 = string:concat(Url1, Category),	
 	string:concat(Url2, "?descending=true&limit=50")
 .
 
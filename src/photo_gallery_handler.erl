-module(photo_gallery_handler).

-export([init/3]).

-export([content_types_provided/2]).
-export([welcome/2]).
-export([terminate/3]).

%% Init
init(_Transport, _Req, []) ->
	{upgrade, protocol, cowboy_rest}.

%% Callbacks
content_types_provided(Req, State) ->
	{[		
		{<<"text/html">>, welcome}	
	], Req, State}.

terminate(_Reason, _Req, _State) ->
	ok.

%% API
welcome(Req, State) -> 

	Url = "http://api.contentapi.ws/videos?channel=world_news&limit=1&skip=4&format=long",
	% io:format("movies url: ~p~n",[Url]),
	{ok, "200", _, Response_mlb} = ibrowse:send_req(Url,[],get,[],[]),
	ResponseParams_mlb = jsx:decode(list_to_binary(Response_mlb)),	
	[Params] = proplists:get_value(<<"articles">>, ResponseParams_mlb),

	% Models_Url = "http://api.contentapi.ws/news?channel=fashion&skip=0&format=short&limit=10",
	Models_Url = "http://contentapi.ws:5984/contentapi_text_maxcdn/_design/yb_entertainment_film/_view/by_id_title_desc_thumb_date?descending=true&limit=10",
	{ok, "200", _, Response_Models} = ibrowse:send_req(Models_Url,[],get,[],[]),
	ResponseParams_Models = jsx:decode(list_to_binary(Response_Models)),
	Models = proplists:get_value(<<"rows">>, ResponseParams_Models),

	% All_Beauty_News_Url = "http://api.contentapi.ws/news?channel=entertainment_music&skip=0&limit=20",
	All_Beauty_News_Url = "http://contentapi.ws:5984/contentapi_text_maxcdn/_design/yb_entertainment_music/_view/short?descending=true&limit=20",
	
	{ok, "200", _, Response_All_Beauty_News} = ibrowse:send_req(All_Beauty_News_Url,[],get,[],[]),
	ResponseParams_All_Beauty_News = jsx:decode(list_to_binary(Response_All_Beauty_News)),
	AllBeautyNews = proplists:get_value(<<"rows">>, ResponseParams_All_Beauty_News),

	% Gallery_Url = "http://api.contentapi.ws/news?channel=image_galleries&skip=0&format=short&limit=12",
	% {ok, "200", _, Response_Gallery} = ibrowse:send_req(Gallery_Url,[],get,[],[]),
	% ResponseParams_Gallery = jsx:decode(list_to_binary(Response_Gallery)),	
	% GalleryParams = proplists:get_value(<<"articles">>, ResponseParams_Gallery),

	Latest_Popular_Videos_Url = "http://api.contentapi.ws/videos?channel=world_news&limit=10&format=short&skip=0",
	{ok, "200", _, Response_Latest_Popular_Videos} = ibrowse:send_req(Latest_Popular_Videos_Url,[],get,[],[]),
	ResponseParams_Latest_Popular_Videos = jsx:decode(list_to_binary(Response_Latest_Popular_Videos)),
	LatestPopularVideosParams = proplists:get_value(<<"articles">>, ResponseParams_Latest_Popular_Videos),

 	{ok, Body} = photo_gallery_dtl:render([{<<"videoParam">>,Params},{<<"Models">>,Models},{<<"allbeautynews">>,AllBeautyNews},{<<"latestPopularVideos">>,LatestPopularVideosParams}]),
 	{Body, Req, State}.	
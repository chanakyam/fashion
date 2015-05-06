-module(morefashiontips_handler).
-author("chanakyam@koderoom.com").
-include("includes.hrl").
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

	Url = "http://api.contentapi.ws/videos?channel=world_news&limit=1&skip=2&format=long",
	% io:format("movies url: ~p~n",[Url]),
	{ok, "200", _, Response_mlb} = ibrowse:send_req(Url,[],get,[],[]),
	ResponseParams_mlb = jsx:decode(list_to_binary(Response_mlb)),	
	[Params] = proplists:get_value(<<"articles">>, ResponseParams_mlb),

	% Latest_Beauty_News_Url1 = "http://api.contentapi.ws/news?channel=beauty&skip=0&limit=1",
	% {ok, "200", _, Response_Latest_Beauty_News1} = ibrowse:send_req(Latest_Beauty_News_Url1,[],get,[],[]),
	% ResponseParams_Latest_Beauty_News1 = jsx:decode(list_to_binary(Response_Latest_Beauty_News1)),
	% LatestBeautyNews1 = proplists:get_value(<<"articles">>, ResponseParams_Latest_Beauty_News1),

	% Latest_Beauty_News_Url = "http://api.contentapi.ws/news?channel=entertainment_film&skip=0&limit=10",
	Latest_Beauty_News_Url = "http://contentapi.ws:5984/contentapi_text_maxcdn/_design/yb_entertainment_film/_view/by_id_title_desc_thumb_date?descending=true&limit=10",
	
	{ok, "200", _, Response_Latest_Beauty_News} = ibrowse:send_req(Latest_Beauty_News_Url,[],get,[],[]),
	ResponseParams_Latest_Beauty_News = jsx:decode(list_to_binary(Response_Latest_Beauty_News)),
	LatestBeautyNews = proplists:get_value(<<"rows">>, ResponseParams_Latest_Beauty_News),

	% Latest_News_Url = "http://api.contentapi.ws/news?channel=entertainment_people&limit=20&skip=0&format=short",
	Latest_News_Url = "http://contentapi.ws:5984/contentapi_text_maxcdn/_design/yb_entertainment_people/_view/short?descending=true&limit=20",
	
	{ok, "200", _, Response_Latest_News} = ibrowse:send_req(Latest_News_Url,[],get,[],[]),
	ResponseParams_Latest_News = jsx:decode(list_to_binary(Response_Latest_News)),
	LatestNewsParams = proplists:get_value(<<"rows">>, ResponseParams_Latest_News),

	% Gallery_Url = "http://api.contentapi.ws/news?channel=image_galleries&skip=0&format=short&limit=12",
	% {ok, "200", _, Response_Gallery} = ibrowse:send_req(Gallery_Url,[],get,[],[]),
	% ResponseParams_Gallery = jsx:decode(list_to_binary(Response_Gallery)),	
	% GalleryParams = proplists:get_value(<<"articles">>, ResponseParams_Gallery),

	Latest_Popular_Videos_Url = "http://api.contentapi.ws/videos?channel=world_news&limit=10&format=short&skip=0",
	{ok, "200", _, Response_Latest_Popular_Videos} = ibrowse:send_req(Latest_Popular_Videos_Url,[],get,[],[]),
	ResponseParams_Latest_Popular_Videos = jsx:decode(list_to_binary(Response_Latest_Popular_Videos)),
	LatestPopularVideosParams = proplists:get_value(<<"articles">>, ResponseParams_Latest_Popular_Videos),
	

	{ok, Body} = morefashiontips_dtl:render([{<<"videoParam">>,Params},{<<"latestbeautynews">>,LatestBeautyNews},{<<"latestnews">>,LatestNewsParams},{<<"latestPopularVideos">>,LatestPopularVideosParams}]),
    {Body, Req, State}.





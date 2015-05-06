-module(play_video_handler).
-author("chanakyam@koderoom.com").

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
	{[{_,Value}], Req2} = cowboy_req:bindings(Req),	

	Url = "http://api.contentapi.ws/videos?channel=world_news&limit=1&skip=6&format=long",
	% io:format("movies url: ~p~n",[Url]),
	{ok, "200", _, Response_mlb} = ibrowse:send_req(Url,[],get,[],[]),
	ResponseParams_mlb = jsx:decode(list_to_binary(Response_mlb)),	
	[Params] = proplists:get_value(<<"articles">>, ResponseParams_mlb),
	
	Url_news = string:concat("http://api.contentapi.ws/v?id=",binary_to_list(Value)),
	{ok, "200", _, ResponseNews} = ibrowse:send_req(Url_news,[],get,[],[]),
	ResNews = string:sub_string(ResponseNews, 1, string:len(ResponseNews) -1 ),
	ParamsNews = jsx:decode(list_to_binary(ResNews)),

	% Gallery_Url = "http://api.contentapi.ws/news?channel=entertainment_music&skip=0&format=short&limit=6",
	Gallery_Url = "http://contentapi.ws:5984/contentapi_text_maxcdn/_design/yb_entertainment_music/_view/short?descending=true&limit=6",
	
	{ok, "200", _, Response_Gallery} = ibrowse:send_req(Gallery_Url,[],get,[],[]),
	ResponseParams_Gallery = jsx:decode(list_to_binary(Response_Gallery)),	
	GalleryParams = proplists:get_value(<<"rows">>, ResponseParams_Gallery),

	Latest_Popular_Videos_Url = "http://api.contentapi.ws/videos?channel=world_news&limit=6&format=short&skip=0",
	{ok, "200", _, Response_Latest_Popular_Videos} = ibrowse:send_req(Latest_Popular_Videos_Url,[],get,[],[]),
	ResponseParams_Latest_Popular_Videos = jsx:decode(list_to_binary(Response_Latest_Popular_Videos)),
	LatestPopularVideosParams = proplists:get_value(<<"articles">>, ResponseParams_Latest_Popular_Videos),

	
	% Models_Url1 = "http://api.contentapi.ws/news?channel=fashion&skip=0&format=short&limit=1",
	% {ok, "200", _, Response_Models1} = ibrowse:send_req(Models_Url1,[],get,[],[]),
	% ResponseParams_Models1 = jsx:decode(list_to_binary(Response_Models1)),
	% Models1 = proplists:get_value(<<"articles">>, ResponseParams_Models1),

	Models_Url = "http://api.contentapi.ws/news?channel=entertainment_people&skip=0&format=short&limit=10",
	{ok, "200", _, Response_Models} = ibrowse:send_req(Models_Url,[],get,[],[]),
	ResponseParams_Models = jsx:decode(list_to_binary(Response_Models)),
	Models = proplists:get_value(<<"articles">>, ResponseParams_Models),

	Latest_Beauty_News_Url = "http://api.contentapi.ws/news?channel=entertainment_film&skip=0&limit=10",
	{ok, "200", _, Response_Latest_Beauty_News} = ibrowse:send_req(Latest_Beauty_News_Url,[],get,[],[]),
	ResponseParams_Latest_Beauty_News = jsx:decode(list_to_binary(Response_Latest_Beauty_News)),
	LatestBeautyNews = proplists:get_value(<<"articles">>, ResponseParams_Latest_Beauty_News),

	{ok, Body} = playvideo_dtl:render([{<<"videoParam">>,Params},{<<"newsParam">>,ParamsNews},{<<"gallery">>,GalleryParams},{<<"latestPopularVideos">>,LatestPopularVideosParams},{<<"Models">>,Models},{<<"latestbeautynews">>,LatestBeautyNews}]),
    {Body, Req2, State}.



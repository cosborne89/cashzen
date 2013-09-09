class PagesController < ApplicationController
	#to make a new route for a new static page, just put "get '/[page]' => 'pages#[page]'" in routes.rb where
	#[page] is [page].html.erb
	#you can also duplicate the route as "get 'pages/[page]' => 'pages#[page]'" if there is a need
	#link with <%= link_to '[Page]', '/[page]' %>
end
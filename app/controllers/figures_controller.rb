class FiguresController < ApplicationController

	get '/figures' do
		@figures = Figure.all
		erb :'/figures/index'
	end

	get '/figures/new' do
		@landmarks = Landmark.all
		@titles = Title.all
		erb :'/figures/new'
	end

	post '/figures' do
		@figure = Figure.create(params[:figure])
		#if creating new landmark
		if params[:landmark][:name] != ""
			new_landmark = Landmark.new(params[:landmark])
			new_landmark.figure_id = @figure.id
			new_landmark.save
		end
		#if creating new title
		if params[:title][:name] != ""
			new_title = Title.create(params[:title])
			FigureTitle.create(title_id: new_title.id, figure_id: @figure.id)
		end

		redirect "/figures/#{@figure.id}"
	end

	get '/figures/:id/edit' do
		@figure = Figure.find_by(id: params[:id])
		@landmarks = Landmark.all
		@titles = Title.all
		erb :'/figures/edit'
	end

	patch '/figures/:id' do
		@figure = Figure.find_by(id: params[:id])
		@figure.update(params[:figure])
		#if creating new landmark
		if params[:landmark][:name] != ""
			new_landmark = Landmark.new(params[:landmark])
			new_landmark.figure_id = @figure.id
			new_landmark.save
		end
		#if creating new title
		if params[:title][:name] != ""
			new_title = Title.create(params[:title])
			FigureTitle.create(title_id: new_title.id, figure_id: @figure.id)
		end
		redirect "/figures/#{@figure.id}"
	end

	get '/figures/:id' do
		@figure = Figure.find_by(id: params[:id])
		erb :'/figures/show'
	end

end

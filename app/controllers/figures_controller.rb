class FiguresController < ApplicationController

	get '/figures/new' do
		@landmarks = Landmark.all
		@titles = Title.all
		erb :'/figures/new'
	end

	post '/figures' do
		@figure = Figure.create(params[:figure])
		####LANDMARKS####
		#if they selected existing landmarks, associate those landmarks with the figure
		# if params["figure"]["landmark_ids"]
		# 	params["figure"]["landmark_ids"].each do |id|
		# 		landmark = Landmark.find_by(id: id)
		# 		landmark.figure_id = @figure.id
		# 		landmark.save
		# 	end
		# end
		#if they created a new landmark, create a new landmark and associate it with the figure
		if params[:landmark][:name] != ""
			new_landmark = Landmark.new(params[:landmark])
			new_landmark.figure_id = @figure.id
			new_landmark.save
		end

		####TITLES####
		#if they selected existing titles, find title_id and create new figure_title with figure_id and title_id
		# if !params["figure"]["title_ids"].empty?
		# 	params["figure"]["title_ids"].each do |id|
		# 		binding.pry
		# 		# title = Title.find_by(id: id)
		# 		# figure_title = FigureTitle.create(figure_id: @figure.id, title_id: id)
		# 		@figure.titles << Title.find(id)
		# 	end
		# end

		#if they created a new title, create a new title and associate it with the figure
		if params[:title][:name] != ""
			new_title = Title.create(params[:title])
			FigureTitle.create(title_id: new_title.id, figure_id: @figure.id)
		end

	end

end

class GurlsController < ApplicationController
  def new
    @gurl = Gurl.new
  end

  def create
    destination = params[:destination] 
    if valid_url?(destination)
      @gurl = Gurl.new(
        dest: destination,
        gatorly: (0...7).map { ('a'..'z').to_a[rand(26)] }.join
      )
      if @gurl.save
        if params[:author] && params[:body]
          Quote.create(
            author: params[:author],
            body: params[:body]
          )
        end
        redirect_to "/generate/#{@gurl.gatorly}"
      else
        render "new.html.erb"
      end
    else
      render "new.html.erb"
    end
  end

  def show
    @gurl = Gurl.find_by(gatorly: params[:gatorly])
    offset = rand(Quote.count)
    @quote = Quote.offset(offset).first
  end

  def redirect
    gurl = Gurl.find_by(gatorly: params[:id])
    redirect_to Addressable::URI.heuristic_parse(gurl.dest).to_s
  end

  private

  def valid_url?(input_dest)
    begin
      Unirest.get(
        Addressable::URI.heuristic_parse(input_dest).to_s
      )
      true
    rescue
      flash[:error] = "We don't recognize that URL. Try again."
      false
    end
  end
end

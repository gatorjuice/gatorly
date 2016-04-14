class GurlsController < ApplicationController
  def new
    @url_message = "Enter the destination URL."
    @gurl = Gurl.new
  end

  def create
    destination = params[:destination]
    if !params[:destination].blank? && Gurl.exists?(dest: destination)
      @gurl = Gurl.find_by(dest: destination)
      @quote = get_quote
      render "show.html.erb"
    else
      if valid_url?(destination)
        @gurl = Gurl.new(
          dest: destination,
          gatorly: (0...7).map { ('a'..'z').to_a[rand(26)] }.join
        )
        if @gurl.save
          unless params[:author].blank? && params[:body].blank?
            Quote.create(
              author: params[:author],
              body: params[:body]
            )
          end
          redirect_to "/generate/#{@gurl.gatorly}"
        else
          @url_message = "There was a problem, try submitting again."
          render "new.html.erb"
        end
      else
        @url_message = "We don't recognize that URL. Please try again."
        render "new.html.erb"
      end
    end
  end

  def show
    @gurl = Gurl.find_by(gatorly: params[:gatorly])
    @quote = get_quote
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
      false
    end
  end

  def get_quote
    offset = rand(Quote.count)
    Quote.offset(offset).first
  end
end

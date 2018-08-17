class ReviewsController <  ApplicationController
  before_action :set_review, only: [:destroy]

  # POST /reviews
  def create
    @vessel = Vessel.find(params[:vessel_id])
    @vessel.reviews.create!(review_params)

    set_rating(@vessel)

    redirect_to vessel_path(params[:vessel_id])
  end

  # DELETE /reviews/1
  def destroy
    @review.destroy

    @vessel = Vessel.find(params[:vessel_id])
    set_rating(@vessel)
    vessel.save!

    redirect_to vessel_path(params[:vessel_id])
  end

  private

  def set_rating(vessel)
    if vessel.reviews
      a = vessel.reviews.map{|a| a[:rating].to_i};
      rating = a.any? ? (a.reduce(:+).to_f / a.size).round : 0
      vessel.rating = rating
    else
      vessel.rating = 0
    end
    vessel.save!
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end

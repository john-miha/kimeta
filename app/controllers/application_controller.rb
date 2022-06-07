class ApplicationController < ActionController::Base
    include Pagy::Backend
    def counts(user)
        @count_charts = user.charts.count
    end
end

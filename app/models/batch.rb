class Batch < ApplicationRecord
    has_many :articles
    has_many :predictions, through: :articles
    has_many :week_results

    # belongs_to :user

    def self.create_with_all(website)
        @website = website

        @batch = Batch.create(name: "default - add a name field to the form")

        @article = Article.create_with_text(@website, @batch.id)

        @date = Scraper.find_publish_date(@article.article_text)

        @nfl_week = GamedayPredictor(@date)

        @week_result = WeekResult.create_with_scores(@nfl_week[0], @nfl_week[1], @nfl_week[2], @batch.id)

        @batch
    end
end
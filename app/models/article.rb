class Article < ApplicationRecord
    has_many :predictions
    belongs_to :batch

    def self.create_with_text(website, id)
        @id = id
        @website = website
        
        @text = Scraper.scrape(@website)
        
        @article = Article.create(article_text: @text, article_url: @website, batch_id: @id)

        @predictions = Scraper.find_predictions(@article.article_text)
        @predictions.each do |prediction| 
            teams = prediction.keys
            Prediction.create(team_a: teams[0], team_b: teams[1], team_a_score: prediction[teams[0]], team_b_score: prediction[teams[1]], article_id: @article.id)
        end
        @article
    end

end

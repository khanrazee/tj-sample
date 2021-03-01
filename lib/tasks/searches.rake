namespace :searches do
  desc "syncs search history with searches table"
  # In Minutes, Can't be less then 1 due to Cron limit. Kept 10 due to Heroku limit
  # Todo : Add spec for rake task.
  SYNC_INTERVAL = 10
  task sync: :environment do
    # Either record is old since user never hit Submit or Its in completed state.
    SearchHistory.where("updated_at <= '#{Time.now.utc - SYNC_INTERVAL.minutes}' OR state = 1").each do |sh|
      # Todo: Use bulk save and batches here.
      search = Search.find_or_create_by(slug: sh.slug)
      search.update(count: (search.count.to_i + 1), term: sh.term )
      sh.delete
    end
  end

end




class MonitorsController < ApplicationController
  
  def heartbeat
    respond_to do |format|
      format.json do
        render :json => {
          'db' => test_db,
          'cache' => test_cache
        }
      end
      format.html do
        test_all
        render layout: false
      end
    end
  end

  def test_all
    test_db && test_cache
  end

  def test_db
    Article.first
    true
  end

  def test_cache
    raise "CacheCheckFail" unless !Rails.cache.exist?('_monitor-heartbeat-foobar')
    true
  end
end
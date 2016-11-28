require 'jobs/base_job'

# Interface: Job
class PlantFieldJob < BaseJob
  attr_reader :field, :workers, :store

  def initialize(field:, workers:, store:)
    @field = field
    @workers = workers
    @store = store

    super
  end

  private

  def on_create
    # FIXME: Should we ask the field for this info, or pass in init?
    store.reserve_seed_stock(10)
    workers.map { |worker| worker.busy = true }
    field.reserve
  end

  def before_work

  end

  def on_work
    store.remove_seed_stock(10)
    workers.map { |worker| worker.tired = true }
    field.percent_sown += 5.0 * workers.count # 5.0 acres per personday
  end

  def on_rescue
    store.unreserve_seed_stock(10)
  end

  def on_finalize
    field.unreserve
    workers.map { |worker| worker.busy = false }
  end
end

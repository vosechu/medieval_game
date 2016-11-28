require 'jobs/base_job'

# Interface: Job
class PlantFieldJob < BaseJob
  attr_reader :field, :workers, :store

  def initialize(field:, workers:, store:)
    @field = field
    @workers = workers
    @store = store

    @desired_seed_stock_amount = 10
    @reserved_seed_stock_amount = 0

    super
  end

  protected

  def on_create
    # FIXME: Should we ask the field for this info, or pass in init?
    @reserved_seed_stock_amount = store.reserve_seed_stock(10)
    workers.map { |worker| worker.busy = true }
    field.reserve
  end

  def before_work

  end

  def on_work
    store.remove_seed_stock(10)
    workers.map { |worker| worker.tired = true }
    field.percent_sown += 5.0 * percent_seed_stock * percent_workers # 5.0 acres per personday
  end

  def on_rescue
    store.unreserve_seed_stock(10)
  end

  def on_finalize
    field.unreserve
    workers.map { |worker| worker.busy = false }
  end

  private

  def percent_seed_stock
    @reserved_seed_stock_amount / @desired_seed_stock_amount
  end

  def percent_workers
    # FIXME: We don't actually have this number yet
    1
  end
end

class BaseJob
  def initialize(**_args)
    on_create
  end

  def work
    begin
      before_work
      on_work
    rescue => e
      on_rescue
      raise e
    ensure
      on_finalize
    end
  end
end

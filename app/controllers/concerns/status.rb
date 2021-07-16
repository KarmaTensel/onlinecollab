module Status
  extend ActiveSupport::Concern

  VALID_STATUSES = ['Draft', 'Publish', 'Archive']

  included do
    validates :status, inclusion: { in: VALID_STATUSES }
  end

  class_methods do
    def published_count
      where(status: 'Publish', visibility:'All').count
    end

    def draft_count
      where(status: 'Draft').count
    end

    def archive_count
      where(status: 'Archive').count
    end
  end

  def archived?
    status == 'Archive'
  end

  def drafted?
    status == 'Draft'
  end

end
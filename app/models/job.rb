class Job < ApplicationRecord
  belongs_to :account
  has_many :applicants, dependent: :destroy

  has_rich_text :description

  validates_presence_of :title, :status, :job_type, :location

  FILTER_PARAMS = %i[query status sort].freeze

  scope :for_account, ->(account_id) { where(account_id: account_id) }
  scope :for_status, ->(status) { status.present? ? where(status: status) : all }
  scope :search_by_title, ->(query) { query.present? ? where('title ILIKE ?', "%#{query}%") : all }
  scope :sorted, ->(selection) { selection.present? ? apply_sort(selection) : all }


  enum status: {
    draft: 'draft',
    open: 'open',
    closed: 'closed'
  }

  enum job_type: {
    full_time: 'full_time',
    part_time: 'part_time'
  }

  def self.filter(filters)
    search_by_title(filters['query'])
      .for_status(filters['status'])
      .sorted(filters['sort'])
  end

  def self.apply_sort(selection)
    return if selection.blank?

    sort, direction = selection.split('-')
    order("#{sort} #{direction}")
  end
end

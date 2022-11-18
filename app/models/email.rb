class Email < ApplicationRecord
  after_create_commit :send_email, if: :outbound?
  has_rich_text :body

  belongs_to :applicant
  belongs_to :user

  validates_presence_of :subject

  enum email_type: {
    outbound: 'outbound',
    inbound: 'inbound'
  }

  def send_email
    ApplicantMailer.contact(email: self).deliver_later
  end
end

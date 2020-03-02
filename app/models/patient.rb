class Patient <ApplicationRecord
  validates_presence_of :name, :age
  has_many :doctor_patients
  has_many :doctors, through: :doctor_patients

  def self.patient_order
    Patient.order('age DESC')
  end
end

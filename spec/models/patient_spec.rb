require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
  end
  describe 'relationships' do
    it {should have_many :doctor_patients}
    it {should have_many(:doctors).through(:doctor_patients)}
  end

  describe "#patient_order" do
    before(:each) do
      @hospital_1 = Hospital.create(name: "Grey Sloan Memorial Hospital")
      @hospital_2 = Hospital.create(name: "Pacific Northwest General Hospital")
      @hospital_3 = Hospital.create(name: "New York Hospital")
      @doctor_1 = Doctor.create(name: "Meredith Grey", specialty: "General Surgery", university: "Harvard University", hospital: @hospital_1)
      @doctor_2 = Doctor.create(name: "Alex Karev", specialty: "Pediatric Surgery", university: "John Hopkins University", hospital: @hospital_2)
      @doctor_3 = Doctor.create(name: "Miranda Bailey", specialty: "General Surgery", university: "Stanford University", hospital: @hospital_3)
      @doctor_4 = Doctor.create(name: "Derek Webber", specialty: "Attending Surgeon", university: "University of Pennsylvania", hospital: @hospital_1)
      @patient_1 = Patient.create(name: "Katie Bryce", age: 27, doctors: [@doctor_1])
      @patient_2 = Patient.create(name: "Denny Duquette", age: 20, doctors: [@doctor_2])
      @patient_3 = Patient.create(name: "Rebecca Pope", age: 13, doctors: [@doctor_1, @doctor_3])
      @patient_4 = Patient.create(name: "Zola Shepard", age: 40, doctors: [@doctor_4])
    end
    it "can list patients from oldest to youngest" do
      expect(Patient.patient_order[0]).to eq(@patient_4)
      expect(Patient.patient_order[1]).to eq(@patient_1)
      expect(Patient.patient_order[2]).to eq(@patient_2)
      expect(Patient.patient_order[3]).to eq(@patient_3)
    end
  end
end

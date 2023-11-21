# frozen_string_literal: true

class AppointmentMailer < ApplicationMailer
  def edit_link_email(appointment)
    @appointment = appointment
    @edit_url = edit_appointment_url(@appointment.id)

    mail(to: @appointment.email, subject: 'Appointment Details')
  end
end

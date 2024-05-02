class CableStoreChannel < ApplicationCable::Channel
  public :transmit

  def subscribed
    @sgid = params[:sgid]
    return reject unless subject
    stream_for subject
    if subject.respond_to? :subscribed
      cable = subject.cable
      cable.transmitter = self
      subject.subscribed cable
    end
  end

  def subject
    @subject ||= GlobalID::Locator.locate_signed @sgid
  end

  def perform_action data
    if subject.respond_to? "perform_#{data['action']}"
      subject.send "perform_#{data['action']}", *data['args']
    else
      puts "No such action: #{data['action']}"
      transmit({error: "No such action: #{data['action']}"})
    end
  end

  def unsubscribed
    if subject.respond_to? :unsubscribed
      cable = subject.cable
      cable.transmitter = self
      subject.unsubscribed cable
    end
  end
end

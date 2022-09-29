class ReservedSlotsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "warehouse_#{params[:id]}_reserved_slots_channel"
  end

  def unsubscribed; end
end

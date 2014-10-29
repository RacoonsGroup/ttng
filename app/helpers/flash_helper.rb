module FlashHelper
  ALERT_TYPES = [:error, :info, :success, :warning]

  def flashes
    # output = ''
    # flash.each do |type, message|
    #   type = type.to_sym
    #   next if message.blank?
    #   type = :success if type == :notice
    #   type = :error   if type == :alert
    #   next unless ALERT_TYPES.include?(type)
    #   output += flash_container(type, message)
    # end
    #
    # raw(output)
  end
end
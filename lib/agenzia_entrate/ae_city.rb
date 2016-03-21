class AeCity

  attr_reader :name, :province, :plate, :cadastral_code

  def initialize (name, cadastral_code, plate, province)
   @name = name
   @cadastral_code = cadastral_code
   @plate = plate
   @province = province
  end

end

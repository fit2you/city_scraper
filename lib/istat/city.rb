class City

  attr_reader :name, :region, :province, :plate, :cf

  def initialize (row, headers)
    @row = row
    @name = value_for(headers[:name_idx])
    @region = value_for(headers[:region_idx])
    # m = value_for(headers[:metropolis_idx]).gsub('-','')
    # p = value_for(headers[:province_idx]).gsub('-','')
    # @province = m + p
    @province = p
    @plate = value_for(headers[:plate_idx])
    @cf = value_for(headers[:cf_idx])
  end

  def value_for(index)
    @row[index]
  end

end
